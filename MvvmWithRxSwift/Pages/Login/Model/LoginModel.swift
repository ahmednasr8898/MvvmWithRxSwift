

import Foundation
struct LoginModel : Codable {
	let status : Int?
	let user : User?
	let msg : String?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case user = "user"
		case msg = "msg"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		user = try values.decodeIfPresent(User.self, forKey: .user)
		msg = try values.decodeIfPresent(String.self, forKey: .msg)
	}

}
