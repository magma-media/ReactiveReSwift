//
//  StandardActionTests.swift
//  ReSwift
//
//  Created by Benjamin Encz on 12/29/15.
//  Copyright © 2015 Benjamin Encz. All rights reserved.
//
import XCTest
import ReactiveReSwift

class StandardActionInitTests: XCTestCase {

    /**
     it can be initialized with just a type
     */
    func testInitWithType() {
        let action = StandardAction(type: "Test")

        XCTAssertEqual(action.type, "Test")
    }

    /**
     it can be initialized with a type and a payload
     */
    func testInitWithTypeAndPayload() {
        let action = StandardAction(type:"Test", payload: ["testKey": 5 as AnyObject])

        let payload = action.payload!["testKey"]! as! Int

        XCTAssertEqual(payload, 5)
        XCTAssertEqual(action.type, "Test")
    }

}

class StandardActionInitSerializationTests: XCTestCase {

    /**
     it can initialize action with a dictionary
     */
    func testCanInitWithDictionary() {
        let actionDictionary: [String: AnyObject] = [
            "type": "TestType" as AnyObject,
            "payload": "ReSwift_Null" as AnyObject,
            "isTypedAction": true as AnyObject
        ]

        let action = StandardAction(dictionary: actionDictionary)

        XCTAssertEqual(action?.type, "TestType")
        XCTAssertNil(action?.payload)
        XCTAssertEqual(action?.isTypedAction, true)
    }

    /**
     it can convert an action to a dictionary
     */
    func testConvertActionToDict() {
        let action = StandardAction(type:"Test", payload: ["testKey": 5 as AnyObject],
                                    isTypedAction: true)

        let dictionary = action.dictionaryRepresentation

        let type = dictionary["type"] as! String
        let payload = dictionary["payload"] as! [String: AnyObject]
        let isTypedAction = dictionary["isTypedAction"] as! Bool

        XCTAssertEqual(type, "Test")
        XCTAssertEqual(payload["testKey"] as? Int, 5)
        XCTAssertEqual(isTypedAction, true)
    }

    /**
     it can serialize / deserialize actions with payload and without custom type
     */
    func testWithPayloadWithoutCustomType() {
        let action = StandardAction(type:"Test", payload: ["testKey": 5 as AnyObject])
        let dictionary = action.dictionaryRepresentation

        let deserializedAction = StandardAction(dictionary: dictionary)

        let payload = deserializedAction?.payload?["testKey"] as? Int

        XCTAssertEqual(payload, 5)
        XCTAssertEqual(deserializedAction?.type, "Test")
    }

    /**
     it can serialize / deserialize actions with payload and with custom type
     */
    func testWithPayloadAndCustomType() {
        let action = StandardAction(type:"Test", payload: ["testKey": 5 as AnyObject],
                                    isTypedAction: true)
        let dictionary = action.dictionaryRepresentation

        let deserializedAction = StandardAction(dictionary: dictionary)

        let payload = deserializedAction?.payload?["testKey"] as? Int

        XCTAssertEqual(payload, 5)
        XCTAssertEqual(deserializedAction?.type, "Test")
        XCTAssertEqual(deserializedAction?.isTypedAction, true)
    }

    /**
     it can serialize / deserialize actions without payload and without custom type
     */
    func testWithoutPayloadOrCustomType() {
        let action = StandardAction(type:"Test", payload: nil)
        let dictionary = action.dictionaryRepresentation

        let deserializedAction = StandardAction(dictionary: dictionary)

        XCTAssertNil(deserializedAction?.payload)
        XCTAssertEqual(deserializedAction?.type, "Test")
    }

    /**
     it can serialize / deserialize actions without payload and with custom type
     */
    func testWithoutPayloadWithCustomType() {
        let action = StandardAction(type:"Test", payload: nil,
                                    isTypedAction: true)
        let dictionary = action.dictionaryRepresentation

        let deserializedAction = StandardAction(dictionary: dictionary)

        XCTAssertNil(deserializedAction?.payload)
        XCTAssertEqual(deserializedAction?.type, "Test")
        XCTAssertEqual(deserializedAction?.isTypedAction, true)
    }

    /**
     it initializer returns nil when invalid dictionary is passed in
     */
    func testReturnsNilWhenInvalid() {
        let deserializedAction = StandardAction(dictionary: [:])

        XCTAssertNil(deserializedAction)
    }
}
