# O썸 포켓

### 프로젝트의 결과물을 한눈에 보고 싶다면?
#### [프로젝트 소개 페이지](https://hjeha.github.io/BithumbCopycat/)

## 개요

### 프로젝트 목표
#### 빗썸 Public API 사용한 앱 구현

### 프로젝트 기간
#### 2022.02.21 ~ 2022.03.13

### 팀원 소개
|황제하|김진영|오동건|
|---|---|---|
|<img width="200" src="https://i.imgur.com/x4f4Vbs.jpg">|<img width="200" src="https://i.imgur.com/TzAWvqX.jpg">|<img width="200" src="https://i.imgur.com/IMKlvRQ.jpg">|
|hyhpwang@gmail.com|zero0204@gmail.com|cafa3@naver.com|
|https://github.com/HJEHA|https://github.com/z3rosmith|https://github.com/DonggeonOh|

### 프로젝트 기술 스택
<img width="300" src="https://i.imgur.com/MCgeDzH.png">

## 앱 구동 화면
### 코인 리스트 화면
|라이트 모드|다크 모드|
|---|---|
|<img width="200" src="https://i.imgur.com/56Wtez4.gif">|<img width="200" src="https://i.imgur.com/dRwSqR2.gif">|

### 코인 상세 화면(차트)
|라이트 모드|다크 모드|
|---|---|
|<img width="200" src="https://i.imgur.com/rYy11N0.gif">|<img width="200" src="https://i.imgur.com/4D0dgNL.gif">|

### 코인 상세 화면(호가)
|라이트 모드|다크 모드|
|---|---|
|<img width="200" src="https://i.imgur.com/0Po9aG2.gif">|<img width="200" src="https://i.imgur.com/x8R2TMb.gif">|


### 코인 상세 화면(체결 내역)
|라이트 모드|다크 모드|
|---|---|
|<img width="200" src="https://i.imgur.com/974EQpQ.gif">|<img width="200" src="https://i.imgur.com/QOVmO5E.gif">|


### 입출금 현황 화면
|라이트 모드|다크 모드|
|---|---|
|<img width="200" src="https://i.imgur.com/lE7djxM.gif">|<img width="200" src="https://i.imgur.com/RyZgcmg.gif">|

### 더보기 화면
|라이트 모드|다크 모드|
|---|---|
|<img width="200" src="https://user-images.githubusercontent.com/98801129/158020405-13af274e-f7ae-4dc0-a93a-410c05ae0523.gif">|<img width="200" src="https://user-images.githubusercontent.com/98801129/158020402-6ff9d99c-8211-46cb-a4b1-b7830a223237.gif">|

## 담당 기능

- **네트워크**(HTTP, WebSocket) 통신 구현
- **다크모드**
- 코인 상세 화면
    - **페이지 뷰 컨트롤러**
    - 우측 상단 차트(****Core Graphics - beginPath****)
- 호가 화면
- 체결 내역 화면


## 트러블 슈팅
### 범용적으로 사용할 수 있는 NetworkService
> 처음에는 API 별로 request() 메서드를 따로 만드려고 했으니 그렇게 되면 중복 코드가 너무 많다고 생각했습니다.
> 하나의 request() 메서드에서 여러 API를 받을 수 있는 방법을 고민해봤습니다.
> 열거형을 사용해서 API 별로 연산 프로퍼티를 만들어서 사용하려고 했으나 그렇게 설계하게 되면 API가 추가될 때마다 열거형을 수정해줘야하는 상황이 생겼습니다.(개방 폐쇄 원칙 위반)
> 다른 방법을 생각한게 프로토콜을 사용하여 API 별로 구체타입을 가지게 되면 중복 코드도 방지할 수 있고, API가 추가될 때마다 기존 코드를 수정해줄 필요가 없기 때문에 확장에 용이하다 판단했습니다.
    
  ![](https://i.imgur.com/fs2ZBrm.png)
  ![](https://i.imgur.com/DwHPIO4.png)
    
### WebSocketNetworkService 테스트
> 네트워크와 무관한 HTTPNetworkService Unit Test는 다음 [링크](https://techblog.woowahan.com/2704/)를 참고해서 진행했습니다.
>
> WebSocketNetworkService도 네트워크와 무관한 Unit Test를 진행하기 위해 URLSessionWebSocketTask 상속 받은 MockWebSocketURLSesstionTask 타입을 만들어 진행하려고 했습니다.
>
> 문제는 URLSessionWebSocketTask의 send(), receive() 메서드의 접근제어가 public으로 되어있어 override가 불가능하다는 점이였습니다.
>
> 다른 방향으로 접근하기 위해 URLSessionWebSocketTaskProviding 프로토콜 내부에 send(), receive를 정의한 후 MockWebSocketURLSesstionTask 타입을 만들어 채택시켰습니다. 
>
>또 실제 WebSocketNetworkService로는 테스트가 불가능하기 때문에 내부 로직이 동일한 MockWebSocketNetworkService 타입을 만들어 Unit Test를 진행했습니다.
>
> 위와 같이 테스트를 진행하면 실제 프로덕션 코드를 테스트한게 아니기 때문에 테스트의 신뢰성은 조금 떨어질 수 있습니다.
>
> 또, 프로덕션 코드의 로직이 변경된다면 Mock 객체의 로직도 변경해줘야한다는 문제점이 있습니다.
> 
> 여러가지 문제점이 있지만 위와 같이 테스트를 진행한 이유는 실제 네트워크로 테스트를 진행하게 되면 네트워크 상황에 따라 테스트의 결과가 달라질 수 있기 때문에 신뢰성 있는 테스트가 불가능하다고 생각하기 때문에 내부 로직이 동일한 MockWebSocketNetworkService 타입을 사용하여 어느정도 신뢰성을 줄 수 있다고 판단했습니다.

### 매수 최고가, 매도 최저가 뷰 화면 노출
> 호가 화면을 스크롤하다 보면 매도 또는 매수 셀만 화면에 노출되게 됩니다. 그럴 경우 반대 주문에 대한 정보를 알 수 없어 매수 최고가, 매도 최저가 데이터를 화면에 보여주면 거래량에 이점이 있을 것 같다는 생각을 했습니다.
> 
> 호가 화면의 컬렉션 뷰의 delegate 메서드 중 scrollViewDidScroll를 이용해 스크롤될 때마다 컬렉션 뷰의 `visibleCells`를 이용해 현재 화면에 보이는 셀의 목록을 가져오고 셀의 아이템(Model)의 타입(매수, 매도)의 개수를 검사하여 주문의 반대되는 뷰를 노출시키도록 구현했습니다.
