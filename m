Return-Path: <zjznliang_popo@163.com>
Received: from 163.com (m12-16.163.com [220.181.12.16])
	by ozlabs.org (Postfix) with SMTP id 4A6D168724
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 14:52:29 +1100 (EST)
Received: from zjzn (unknown [61.183.211.137])
	by smtp9 (Coremail) with SMTP id GEB0f936e0NJsFMF.1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 11:37:05 +0800 (CST)
Date: Thu, 17 Nov 2005 11:37:28 +0800
From: "zjznliang" <zjznliang_popo@163.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-Id: <20051117035229.4A6D168724@ozlabs.org>
Subject: U-Boot MPC859TnnA support !
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

SGkgbGludXhwcGMtZW1iZWRkZWSjoQ0KDQoJICAgICAgICAgIEkgYW0gcG9ydGluZyBVLUJvb3Qg
b24gdGhlIE1QQzg1OVRubkEgY2FyZCxidXQgVS1Cb290IGNhbid0IGZpbmQgdGhlIENQVSBpbiB0
aGUgaW5pdGlhbGl6YXRpb24gLiBJIGNoZWNrIHRoZSBjb2RlICx0aGVyZSBpcyBub3QgdHlwZSBv
ZiBNUEM4NTlUbm5BIHRvIHN1cHBvcnQgLlRoZSBVLUJvb3QgdmVyc2lvbiBpcyAxLjEuMy4NCg0K
CQkJCVRoZXJlIE1QQyBmYW1pbHkgdmVyc2lvbnMgaXMgaGVyZSA6DQoJCQkJaHR0cDovL3d3dy5m
cmVlc2NhbGUuY29tL3dlYmFwcC9zcHMvc2l0ZS9wcm9kX3N1bW1hcnkuanNwP2NvZGU9TVBDODU5
VCZzcmNoPTEgDQoNCgkJCQlNUEM4NjYgRmFtaWx5IFZlcnNpb25zIGFuZCBNYXNrcyANCgkJCQlS
ZXYgCU1hc2sgCVByb2Nlc3MgCVF1YWwgCUlNTVJbMTY6MzFdIAlNaWNyb2NvZGUgUkVWX05VTSAJ
UGFydCBOdW1iZXIgDQoJCQkJMC4zIAkzTDkwSCAJSGlQNlcgCQlNQyAJCTB4MDgwMCAJCQkJMHgw
MDAzIAkJCQkJCQkJICBNUEM4NjZQbm4NCgkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJ
CQkgIAlNUEM4NjZUbm4NCgkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJTVBDODU5
VG5uDQoJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCU1QQzg1OURTTG5uDQoJCQkJ
CQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCU1QQzg1MlRubiANCgkJCQlBLjAgCTBMOTZS
IAlIaVA2VyAJCU1DIAkJMHgwODAxIAkJCQkweDAwMDQgCQkJCQkJCQlNUEM4NjZQbm5BDQoJCQkJ
CQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCU1QQzg2NlRubkENCgkJCQkJCQkJCQkJCQkJ
CQkJCQkJCQkJCQkJCQkJCQkJCQkJTVBDODU5VG5uQQ0KCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJ
CQkJCQkJCQkJCQlNUEM4NTlEU0xubkEgDQoNCgkJCQlUaGUgY29kZSBpbiBVLUJvb3QgaXMgaW4g
dGhlIGNoZWNrX0NQVSgpICAobGluZSA0OCBvZiAiXGNwdVxtcGM4eHhcQ3B1LmMiKQ0KCQkJCVRo
ZSBVLUJvb3Qgc3VwcG9ydHMgdGhlIHR5cGUgb2YgMHgwODAwMDAwMyBidXQgbm90IDB4MDgwMTAw
MDQsIHNvIGFkZCB0aGUgY29kZSBmb3IgMHgwODAxMDAwNCx5b3Ugd2lsbCBmaW5kIHlvdXIgTVBD
eG5uQSBjcHUgLjopDQogCQkJCQ0KICAgICAgICAgICAgIAlQZXJoYXBzIEkgd2lsbCBiZSBhIGhl
bHAuDQqhoaGhemp6bmxpYW5nDQqhoaGhoaGhoXpqem5saWFuZ19wb3BvQDE2My5jb20NCqGhoaGh
oaGhoaGhoTIwMDUtMTEtMTcNCg==
