import XCTest

@MainActor
class ___FILEBASENAMEASIDENTIFIER___<Parent: Robot>: SheetRobot<Parent> {
  private lazy var item = root.id(/*@START_MENU_TOKEN@*/.id/*@END_MENU_TOKEN@*/)

  init(_ app: XCUIApplication, parent: Parent) {
    super.init(
      app, root: app.otherElements(/*@START_MENU_TOKEN@*/.ROOT_ID/*@END_MENU_TOKEN@*/),
      parent: parent)

    XCTAssert(root.waitForExistence(timeout: 2))
  }

  // MARK: User Actions

  // MARK: Checks

}
