Return-Path: <Priyanka.Jain@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0132.outbound.protection.outlook.com [65.55.169.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A9851A03A0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 15:04:41 +1000 (AEST)
From: Priyanka Jain <Priyanka.Jain@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, York Sun
 <yorksun@freescale.com>
Subject: RE: [v3] powerpc/fsl-booke: Add T1040D4RDB/T1042D4RDB board support
Date: Mon, 10 Aug 2015 05:04:34 +0000
Message-ID: <BY1PR0301MB085343608CAF68AC3839C077EC700@BY1PR0301MB0853.namprd03.prod.outlook.com>
References: <1438232635-11753-1-git-send-email-Priyanka.Jain@freescale.com>
 <20150808024043.GA29646@home.buserror.net>
In-Reply-To: <20150808024043.GA29646@home.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGVsbG8gU2NvdHQsIA0KDQpUMTA0MEQ0UkRCLCBUMTA0MkQ0UkRCIGFyZSBjb21wbGV0ZWx5IG5l
dyBib2FyZHMuIA0KVGhleSBjYW4gc3VwcG9ydCBERFI0IG1lbW9yeSwgbmV3IHNlcmRlcyBwcm90
b2NvbCAweDg2LCBldGggcGh5IGFkZHJlc3NlcyBhcmUgZGlmZmVyZW50ICh0aGFuIHByZXZpb3Vz
IGJvYXJkcyksIG5vLiBvZiBldGggcG9ydHMgYXJlIGRpZmZlcmVudCwgZXRjDQoNClJlZ2FyZHMN
ClByaXlhbmthDQoNCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
V29vZCBTY290dC1CMDc0MjENCj4gU2VudDogU2F0dXJkYXksIEF1Z3VzdCAwOCwgMjAxNSA4OjEx
IEFNDQo+IFRvOiBKYWluIFByaXlhbmthLUIzMjE2Nw0KPiBDYzogbGludXhwcGMtZGV2QGxpc3Rz
Lm96bGFicy5vcmc7IFN1biBZb3JrLVI1ODQ5NQ0KPiBTdWJqZWN0OiBSZTogW3YzXSBwb3dlcnBj
L2ZzbC1ib29rZTogQWRkIFQxMDQwRDRSREIvVDEwNDJENFJEQiBib2FyZA0KPiBzdXBwb3J0DQo+
IA0KPiBPbiBUaHUsIEp1bCAzMCwgMjAxNSBhdCAxMDozMzo1NUFNICswNTMwLCBQcml5YW5rYSBK
YWluIHdyb3RlOg0KPiA+IFQxMDQwRDRSREIvVDEwNDJENFJEQiBhcmUgRnJlZXNjYWxlIFJlZmVy
ZW5jZSBEZXNpZ24gQm9hcmQgd2hpY2ggY2FuDQo+ID4gc3VwcG9ydCBUMTA0MC9UMTA0MiBRb3JJ
USBQb3dlciBBcmNoaXRlY3R1cmXihKIgcHJvY2Vzc29yIHJlc3BlY3RpdmVseQ0KPiANCj4gV2hh
dCBpcyB0aGUgYWN0dWFsIG5hbWUgb2YgdGhpcyBib2FyZD8NCj4gaHR0cDovL3BhdGNod29yay5v
emxhYnMub3JnL3BhdGNoLzUwNDk0NC8gY2hhbmdlcyB0aGUgbmFtZSBpbiBVLUJvb3QNCj4gZnJv
bSAiVDEwNDBENFJEQiIgdG8gIlQxMDQwUkRCX0REUjQiLg0KPiANCj4gSXMgaXQgcmVhbGx5IGEg
ZGlmZmVyZW50IGJvYXJkLCBvciBqdXN0IGRpZmZlcmVudCBSQU0/ICBJZiB0aGUgbGF0dGVyLCB3
ZSBkb24ndA0KPiBzcGVjaWZ5IHRoZSBSQU0gdHlwZSBpbiB0aGUgZGV2aWNlIHRyZWUsIHNvIHdo
eSBkbyB3ZSBuZWVkIHNlcGFyYXRlIGRldmljZQ0KPiB0cmVlcz8NCj4gDQo+IC1TY290dA0K
