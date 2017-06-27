Return-Path: <madalin.bucur@nxp.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20040.outbound.protection.outlook.com [40.107.2.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxbY44k0NzDr1g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 16:26:31 +1000 (AEST)
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Fabio Estevam
 <festevam@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fsl/fman: add dependency on HAS_DMA
Date: Tue, 27 Jun 2017 06:26:25 +0000
Message-ID: <AM5PR0402MB2691567A7CBC51D3A11E2997ECDC0@AM5PR0402MB2691.eurprd04.prod.outlook.com>
References: <1498489947-17272-1-git-send-email-madalin.bucur@nxp.com>
 <CAOMZO5AWgPv6bOFjpt4vC1PSMNpC+dpR2A90+fc2Z_uojoUAmA@mail.gmail.com>
 <CAMuHMdW54XAVGvx14286Ot5itGoTPPfaWA75fJH4PhVz9UQwUQ@mail.gmail.com>
In-Reply-To: <CAMuHMdW54XAVGvx14286Ot5itGoTPPfaWA75fJH4PhVz9UQwUQ@mail.gmail.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBnZWVydC51eXR0ZXJob2V2ZW5A
Z21haWwuY29tIFttYWlsdG86Z2VlcnQudXl0dGVyaG9ldmVuQGdtYWlsLmNvbV0NCj4gT24gQmVo
YWxmIE9mIEdlZXJ0IFV5dHRlcmhvZXZlbg0KPiBTZW50OiBNb25kYXksIEp1bmUgMjYsIDIwMTcg
NzoxNyBQTQ0KPiBUbzogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBDYzog
TWFkYWxpbi1jcmlzdGlhbiBCdWN1ciA8bWFkYWxpbi5idWN1ckBueHAuY29tPjsNCj4gbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pjsg
bGludXhwcGMtDQo+IGRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1rZXJuZWwgPGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGZzbC9mbWFuOiBh
ZGQgZGVwZW5kZW5jeSBvbiBIQVNfRE1BDQo+IA0KPiBPbiBNb24sIEp1biAyNiwgMjAxNyBhdCA1
OjIwIFBNLCBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+IE9u
IE1vbiwgSnVuIDI2LCAyMDE3IGF0IDEyOjEyIFBNLCBNYWRhbGluIEJ1Y3VyIDxtYWRhbGluLmJ1
Y3VyQG54cC5jb20+DQo+IHdyb3RlOg0KPiA+PiBBIHByZXZpb3VzIGNvbW1pdCBpbnNlcnRlZCBh
IGRlcGVuZGVuY3kgb24gRE1BIEFQSSB0aGF0IHJlcXVpcmVzDQo+ID4+IEhBU19ETUEgdG8gYmUg
YWRkZWQgaW4gS2NvbmZpZy4NCj4gPg0KPiA+IEl0IHdvdWxkIGJlIG5pY2UgdG8gc3BlY2lmeSB0
aGUgY29tbWl0IHRoYXQgY2F1c2VkIHRoaXMuDQo+IA0KPiBUaGF0IHdvdWxkIGJlIGNvbW1pdCA1
NTY3ZTk4OTE5OGI1YThkICgiZnNsL2ZtYW46IHByb3BhZ2F0ZSBkbWFfb3BzIikuDQo+IA0KPiBI
b3dldmVyLCBub25lIG9mIHRoZSBmbWFuIGNvZGUgdXNlcyBhbnkgRE1BIEFQSSBjYWxscywgc28g
SU1ITw0KPiB0aGUgc2V0X2RtYV9vcHMoKSBzaG91bGQgYmUgZG9uZSBzb21ld2hlcmUgZWxzZS4N
Cg0KVGhlIEV0aGVybmV0IGRyaXZlciBpcyBtYWtpbmcgdXNlIG9mIHRoZSBETUEgb3BzIHNldCBo
ZXJlLg0KDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMg
b2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtDQo+IG02OGsub3JnDQo+IA0KPiBJ
biBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15
c2VsZiBhIGhhY2tlci4NCj4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMg
SSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UNCj4gdGhhdC4NCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
