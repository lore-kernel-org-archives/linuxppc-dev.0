Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0049.outbound.protection.outlook.com [104.47.42.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401gbN37h5zDrKY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 05:43:23 +1100 (AEDT)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "madalin.bucur@nxp.com"
 <madalin.bucur@nxp.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "leoyang.li@nxp.com" <leoyang.li@nxp.com>, "camelia.groza@nxp.com"
 <camelia.groza@nxp.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/5] DPAA Ethernet fixes
Date: Wed, 14 Mar 2018 18:43:17 +0000
Message-ID: <1521052994.4790.148.camel@infinera.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
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

T24gV2VkLCAyMDE4LTAzLTE0IGF0IDA4OjM3IC0wNTAwLCBNYWRhbGluIEJ1Y3VyIHdyb3RlOg0K
PiBIaSwNCj4gDQo+IFRoaXMgcGF0Y2ggc2V0IGlzIGFkZHJlc3Npbmcgc2V2ZXJhbCBpc3N1ZXMg
aW4gdGhlIERQQUEgRXRoZXJuZXQNCj4gZHJpdmVyIHN1aXRlOg0KPiANCj4gIC0gbW9kdWxlIHVu
bG9hZCBjcmFzaCBjYXVzZWQgYnkgd3JvbmcgcmVmZXJlbmNlIHRvIGRldmljZSBiZWluZyBsZWZ0
DQo+ICAgIGluIHRoZSBjbGVhbnVwIGNvZGUgYWZ0ZXIgdGhlIERTQSByZWxhdGVkIGNoYW5nZXMN
Cj4gIC0gc2NoZWR1bGluZyB3aWxlIGF0b21pYyBidWcgaW4gUU1hbiBjb2RlIHJldmVhbGVkIGR1
cmluZyBkcGFhX2V0aA0KPiAgICBtb2R1bGUgdW5sb2FkDQo+ICAtIGEgY291cGxlIG9mIGVycm9y
IGNvdW50ZXIgZml4ZXMsIGEgZHVwbGljYXRlZCBpbml0IGluIGRwYWFfZXRoLg0KDQpobW0sIHNv
bWUgb2YgdGhlc2UoYWxsPykgYnVncyBhcmUgaW4gc3RhYmxlIHRvbywgQ0M6IHN0YWJsZSBwZXJo
YXBzPyANCg0KPiANCj4gTWFkYWxpbg0KPiANCj4gQ2FtZWxpYSBHcm96YSAoMyk6DQo+ICAgZHBh
YV9ldGg6IHJlbW92ZSBkdXBsaWNhdGUgaW5pdGlhbGl6YXRpb24NCj4gICBkcGFhX2V0aDogaW5j
cmVtZW50IHRoZSBSWCBkcm9wcGVkIGNvdW50ZXIgd2hlbiBuZWVkZWQNCj4gICBkcGFhX2V0aDog
cmVtb3ZlIGR1cGxpY2F0ZSBpbmNyZW1lbnQgb2YgdGhlIHR4X2Vycm9ycyBjb3VudGVyDQo+IA0K
PiBNYWRhbGluIEJ1Y3VyICgyKToNCj4gICBzb2MvZnNsL3FibWFuOiBmaXggaXNzdWUgaW4gcW1h
bl9kZWxldGVfY2dyX3NhZmUoKQ0KPiAgIGRwYWFfZXRoOiBmaXggZXJyb3IgaW4gZHBhYV9yZW1v
dmUoKQ0KPiANCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9kcGFhL2RwYWFfZXRo
LmMgfCAgOCArKysrLS0tLQ0KPiAgZHJpdmVycy9zb2MvZnNsL3FibWFuL3FtYW4uYyAgICAgICAg
ICAgICAgICAgICB8IDI4ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjEu
MA0KPiANCg==
