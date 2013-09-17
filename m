Return-Path: <B32579@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9ECF52C00D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 12:12:38 +1000 (EST)
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] powerpc/mpc85xx:Add initial device tree support of T104x
Date: Tue, 17 Sep 2013 02:11:47 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F874F8CA17@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1378882686-19454-1-git-send-email-prabhakar@freescale.com>
 <1378941854.12204.439.camel@snotra.buserror.net>
 <071A08F2C6A57E4E94D980ECA553F874F607C5@039-SN1MPN1-006.039d.mgd.msft.net>
 <1379366325.2536.178.camel@snotra.buserror.net>
In-Reply-To: <1379366325.2536.178.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Sethi Varun-B16395 <B16395@freescale.com>,
 Jain Priyanka-B32167 <B32167@freescale.com>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE3LCAyMDEzIDI6NDkgQU0NCj4gVG86IEt1
c2h3YWhhIFByYWJoYWthci1CMzI1NzkNCj4gQ2M6IFdvb2QgU2NvdHQtQjA3NDIxOyBsaW51eHBw
Yy1kZXZAbGlzdHMub3psYWJzLm9yZzsNCj4gZ2FsYWtAa2VybmVsLmNyYXNoaW5nLm9yZzsgQWdn
cndhbCBQb29uYW0tQjEwODEyOyBKYWluIFByaXlhbmthLUIzMjE2NzsNCj4gU2V0aGkgVmFydW4t
QjE2Mzk1DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHBvd2VycGMvbXBjODV4eDpBZGQgaW5pdGlh
bCBkZXZpY2UgdHJlZSBzdXBwb3J0IG9mDQo+IFQxMDR4DQo+IA0KPiBPbiBGcmksIDIwMTMtMDkt
MTMgYXQgMDI6MzAgLTA1MDAsIEt1c2h3YWhhIFByYWJoYWthci1CMzI1Nzkgd3JvdGU6DQo+ID4g
PiBJIGFsc28gcXVlc3Rpb24gdGhlIG5lZWQgdG8gZGVmaW5lIHNlcGFyYXRlIHQxMDQwIGNvbXBh
dGlibGUgdmFsdWVzDQo+ID4gPiBmb3IgYWxsIG9mIHRoZXNlLCBpZiB0aGUgb25seSBkaWZmZXJl
bmNlIGlzIHdoZXRoZXIgdGhlIG9uYm9hcmQNCj4gPiA+IHN3aXRjaCBpcyBlbmFibGVkIG9yIG5v
dC4NCj4gPiA+DQo+ID4NCj4gPiBzbyBzaG91bGQgSSB1c2UgVDEwNHggYXMgY29tcGF0aWJsZSBm
aWVsZC4gYW5kIGluIFQxMDQwIGRldmljZSB0cmVlIGFkZA0KPiBleHRyYSBub2RlIGZvciBsMiBz
d2l0Y2guDQoNCkkgYW0gdXNpbmcgVDEwNDIgYXMgYmFzZSBkdHMgYW5kIFQxMDQwIGluY2x1ZGVz
IFQxMDQwICsgbDJzd2l0Y2guIA0KDQpzbyBpZiBJIHVzZSBUMTA0MiBpbiBjb21wYXRpYmxlLiBJ
dCB3aWxsIGdpdmUgd3JvbmcgZmllbGQgZm9yIHNvbWVvbmUgd29ya2luZyBvbiBUMTA0MFFEUy4N
Cg0KYmVzdCBzb2x1dGlvbiBzaG91bGQgYmUgdG8gaGF2ZSANCiBhKSBoYXZlIFQxMDQyIGluIGNv
bXBhdGlibGUgZmllbGQuDQogYikgVDEwNDAgZHRzIG92ZXJyaWRlIFQxMDQyIHRvIHQxMDQwIGlu
IGNvbXBhdGlibGUgZmllbGQuDQppdCB3aWxsIGdpdmUgY29ycmVjdCBwaWN0dXJlDQoNCg0KUmVn
YXJkcywNClByYWJoYWthcg0KDQo=
