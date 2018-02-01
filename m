Return-Path: <qiang.zhao@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0049.outbound.protection.outlook.com [104.47.1.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zX9Lc6Z3hzF0SX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 17:33:58 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [bug report] fsl/qe: setup clock source for TDM mode
Date: Thu, 1 Feb 2018 06:33:52 +0000
Message-ID: <AM3PR04MB11853CC089DBBA769C8E9F7691FA0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <20180131152933.GA20827@mwanda>
In-Reply-To: <20180131152933.GA20827@mwanda>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T24gMjAxOC8xLzMxIDIzOjMwLCBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5j
b20+IHdyb3RlDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEYW4gQ2FycGVu
dGVyIFttYWlsdG86ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tXSANClNlbnQ6IDIwMTjE6jHUwjMx
yNUgMjM6MzANClRvOiBRaWFuZyBaaGFvIDxxaWFuZy56aGFvQG54cC5jb20+DQpDYzogbGludXhw
cGMtZGV2QGxpc3RzLm96bGFicy5vcmcNClN1YmplY3Q6IFtidWcgcmVwb3J0XSBmc2wvcWU6IHNl
dHVwIGNsb2NrIHNvdXJjZSBmb3IgVERNIG1vZGUNCg0KSGVsbG8gWmhhbyBRaWFuZywNCg0KVGhl
IHBhdGNoIGJiOGIyMDYyYWZmMzogImZzbC9xZTogc2V0dXAgY2xvY2sgc291cmNlIGZvciBURE0g
bW9kZSINCmZyb20gSnVuIDYsIDIwMTYsIGxlYWRzIHRvIHRoZSBmb2xsb3dpbmcgc3RhdGljIGNo
ZWNrZXIgd2FybmluZzoNCg0KCWRyaXZlcnMvc29jL2ZzbC9xZS91Y2MuYzo2MjkgdWNjX2dldF90
ZG1fc3luY19zaGlmdCgpDQoJd2FybjogYm90aCBzaWRlcyBvZiB0ZXJuYXJ5IHRoZSBzYW1lOiAn
MzAnIFJYX1NZTkNfU0hJRlRfQkFTRSBSWF9TWU5DX1NISUZUX0JBU0UNCg0KZHJpdmVycy9zb2Mv
ZnNsL3FlL3VjYy5jDQogICA2MjUgIHN0YXRpYyB1MzIgdWNjX2dldF90ZG1fc3luY19zaGlmdChl
bnVtIGNvbW1fZGlyIG1vZGUsIHUzMiB0ZG1fbnVtKQ0KICAgNjI2ICB7DQogICA2MjcgICAgICAg
ICAgdTMyIHNoaWZ0Ow0KICAgNjI4ICANCiAgIDYyOSAgICAgICAgICBzaGlmdCA9IChtb2RlID09
IENPTU1fRElSX1JYKSA/IFJYX1NZTkNfU0hJRlRfQkFTRSA6IFJYX1NZTkNfU0hJRlRfQkFTRTsN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF5eXl5eXl5eXl5eXl5eXl5eXg0KDQpNYXliZSB0aGlzIG9uZSBzaG91bGQg
aGF2ZSBiZWVuIFRYXz8NCg0KVGhhbmsgeW91IHZlcnkgbXVjaCwgaXQgaXMgYSB0eXBvLCBJIHdp
bGwgc2VuZCBhIHBhdGNoIHRvIGZpeCBpdC4NCg0KQlINClFpYW5nIFpoYW8NCg==
