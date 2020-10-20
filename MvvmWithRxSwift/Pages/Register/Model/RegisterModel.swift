

import Foundation
struct RegisterModel: Codable {
	let status : Int?
	let msg : String?
	let api_token : String?
	let user : User?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case msg = "msg"
		case api_token = "api_token"
		case user = "user"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		msg = try values.decodeIfPresent(String.self, forKey: .msg)
		api_token = try values.decodeIfPresent(String.self, forKey: .api_token)
		user = try values.decodeIfPresent(User.self, forKey: .user)
	}

}
