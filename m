Return-Path: <prabhakar@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6DE3B2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 14:31:36 +1100 (EST)
From: "prabhakar@freescale.com" <prabhakar@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 1/2][v8] driver/memory:Move Freescale IFC driver to a
 common driver
Date: Tue, 4 Feb 2014 03:31:22 +0000
Message-ID: <4523a32c7d304ef694929207d25b7732@DM2PR03MB464.namprd03.prod.outlook.com>
References: <1391161199-28018-1-git-send-email-prabhakar@freescale.com>
 <1391469748.6733.99.camel@snotra.buserror.net>
In-Reply-To: <1391469748.6733.99.camel@snotra.buserror.net>
Content-Type: multipart/mixed;
 boundary="_002_4523a32c7d304ef694929207d25b7732DM2PR03MB464namprd03pro_"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Arnd
 Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_002_4523a32c7d304ef694929207d25b7732DM2PR03MB464namprd03pro_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMDQsIDIwMTQgNDo1MiBBTQ0KPiBUbzogS3Vz
aHdhaGEgUHJhYmhha2FyLUIzMjU3OQ0KPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5v
cmc7IEFybmQgQmVyZ21hbm4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdW3Y4XSBkcml2ZXIv
bWVtb3J5Ok1vdmUgRnJlZXNjYWxlIElGQyBkcml2ZXIgdG8gYSBjb21tb24NCj4gZHJpdmVyDQo+
IA0KPiBPbiBGcmksIDIwMTQtMDEtMzEgYXQgMTU6MDkgKzA1MzAsIFByYWJoYWthciBLdXNod2Fo
YSB3cm90ZToNCj4gPiAgRnJlZXNjYWxlIElGQyBjb250cm9sbGVyIGhhcyBiZWVuIHVzZWQgZm9y
IG1wYzh4eHguIEl0IHdpbGwgYmUgdXNlZA0KPiA+IGZvciBBUk0tYmFzZWQgU29DIGFzIHdlbGwu
IFRoaXMgcGF0Y2ggbW92ZXMgdGhlIGRyaXZlciB0bw0KPiA+IGRyaXZlci9tZW1vcnkgIGFuZCBm
aXggdGhlIGhlYWRlciBmaWxlIGluY2x1ZGVzLg0KPiA+DQo+ID4gIEFsc28gcmVtb3ZlIG1vZHVs
ZV9wbGF0Zm9ybV9kcml2ZXIoKSBhbmQgIGluc3RlYWQgY2FsbA0KPiA+ICBwbGF0Zm9ybV9kcml2
ZXJfcmVnaXN0ZXIoKSBmcm9tIHN1YnN5c19pbml0Y2FsbCgpIHRvIG1ha2Ugc3VyZSB0aGlzDQo+
ID4gbW9kdWxlICBoYXMgYmVlbiBsb2FkZWQgYmVmb3JlIE1URCBwYXJ0aXRpb24gcGFyc2luZyBz
dGFydHMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmFiaGFrYXIgS3VzaHdhaGEgPHByYWJo
YWthckBmcmVlc2NhbGUuY29tPg0KPiA+IEFja2VkLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFy
bmRiLmRlPg0KPiANCj4gQWdhaW4sIHdoZW4gZGlkIEFybmQgYWNrIHRoaXM/DQo+IA0KDQpIaSBT
Y290dCwNCg0KSSBndWVzcyB5b3UgbWlzc2VkIGhpcyBtYWlsIG9uIGtlcm5lbC5vcmcuIFBsZWFz
ZSBmaW5kIGF0dGFjaGVkIG1haWwuDQoNCg0KPiA+ICAuLi4ve3Bvd2VycGMgPT4gbWVtb3J5LWNv
bnRyb2xsZXJzfS9mc2wvaWZjLnR4dCAgICB8ICAgIDANCj4gPiAgYXJjaC9wb3dlcnBjL0tjb25m
aWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA0IC0tLS0NCj4gPiAgYXJjaC9w
b3dlcnBjL3N5c2Rldi9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxIC0NCj4g
PiAgZHJpdmVycy9tZW1vcnkvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
ICA4ICsrKysrKysrDQo+ID4gIGRyaXZlcnMvbWVtb3J5L01ha2VmaWxlICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gIHthcmNoL3Bvd2VycGMvc3lzZGV2ID0+IGRyaXZl
cnMvbWVtb3J5fS9mc2xfaWZjLmMgIHwgICAgOCArKysrKystLQ0KPiA+ICBkcml2ZXJzL210ZC9u
YW5kL2ZzbF9pZmNfbmFuZC5jICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKy0NCj4gPiAgLi4u
L2luY2x1ZGUvYXNtID0+IGluY2x1ZGUvbGludXh9L2ZzbF9pZmMuaCAgICAgICAgfCAgICAwDQo+
ID4gIDggZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkgIHJl
bmFtZQ0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy97cG93ZXJwYyA9Pg0K
PiA+IG1lbW9yeS1jb250cm9sbGVyc30vZnNsL2lmYy50eHQgKDEwMCUpICByZW5hbWUge2FyY2gv
cG93ZXJwYy9zeXNkZXYgPT4NCj4gPiBkcml2ZXJzL21lbW9yeX0vZnNsX2lmYy5jICg5OCUpICBy
ZW5hbWUge2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbSA9Pg0KPiA+IGluY2x1ZGUvbGludXh9L2Zz
bF9pZmMuaCAoMTAwJSkNCj4gDQo+IERvIHdlIG5lZWQgYSBNQUlOVEFJTkVSUyBlbnRyeSBmb3Ig
dGhpcz8gIEkgZG9uJ3Qgc2VlIGFueXRoaW5nIGNvdmVyaW5nDQo+IGRyaXZlcnMvbWVtb3J5IGN1
cnJlbnRseS4NCj4gDQoNCkkgYW0gbm90IHN1cmUgYWJvdXQgdGhpcy4gDQoNClJlZ2FyZHMsDQpQ
cmFiaGFrYXINCg==

--_002_4523a32c7d304ef694929207d25b7732DM2PR03MB464namprd03pro_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Tue, 04 Feb 2014 03:31:19 GMT";
	modification-date="Tue, 04 Feb 2014 03:31:19 GMT"

Received: from BLUPR03MB456.namprd03.prod.outlook.com (10.141.78.148) by
 DM2PR03MB464.namprd03.prod.outlook.com (10.141.85.23) with Microsoft SMTP
 Server (TLS) id 15.0.847.13 via Mailbox Transport; Wed, 15 Jan 2014 13:32:17
 +0000
Received: from BLUPR03MB391.namprd03.prod.outlook.com (10.141.78.21) by
 BLUPR03MB456.namprd03.prod.outlook.com (10.141.78.148) with Microsoft SMTP
 Server (TLS) id 15.0.847.13; Wed, 15 Jan 2014 13:32:14 +0000
Received: from BLUPR03CA035.namprd03.prod.outlook.com (10.141.30.28) by
 BLUPR03MB391.namprd03.prod.outlook.com (10.141.78.21) with Microsoft SMTP
 Server (TLS) id 15.0.847.13; Wed, 15 Jan 2014 13:32:14 +0000
Received: from BN1BFFO11FD012.protection.gbl (2a01:111:f400:7c10::1:119) by
 BLUPR03CA035.outlook.office365.com (2a01:111:e400:879::28) with Microsoft
 SMTP Server (TLS) id 15.0.842.7 via Frontend Transport; Wed, 15 Jan 2014
 13:32:14 +0000
Received: from ch1outboundpool.messaging.microsoft.com (216.32.181.182) by
 BN1BFFO11FD012.mail.protection.outlook.com (10.58.144.75) with Microsoft SMTP
 Server (TLS) id 15.0.847.12 via Frontend Transport; Wed, 15 Jan 2014 13:32:13
 +0000
Received: from mail133-ch1-R.bigfish.com (10.43.68.249) by
 CH1EHSOBE003.bigfish.com (10.43.70.53) with Microsoft SMTP Server id
 14.1.225.22; Wed, 15 Jan 2014 13:32:12 +0000
Received: from mail133-ch1 (localhost [127.0.0.1])	by
 mail133-ch1-R.bigfish.com (Postfix) with ESMTP id D29C41A012D;	Wed, 15 Jan
 2014 13:32:12 +0000 (UTC)
Received: from mail133-ch1 (localhost.localdomain [127.0.0.1]) by mail133-ch1
 (MessageSwitch) id 1389792730814579_18221; Wed, 15 Jan 2014 13:32:10 +0000
 (UTC)
Received: from CH1EHSMHS026.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.244])	by mail133-ch1.bigfish.com (Postfix) with ESMTP id
 AFBEC4E005B;	Wed, 15 Jan 2014 13:32:10 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CH1EHSMHS026.bigfish.com
 (10.43.70.26) with Microsoft SMTP Server (TLS) id 14.16.227.3; Wed, 15 Jan
 2014 13:32:10 +0000
Received: from mail18-ch1-R.bigfish.com (216.32.181.169) by mail.freescale.net
 (10.84.1.17) with Microsoft SMTP Server (TLS) id 14.3.158.2; Wed, 15 Jan 2014
 13:31:43 +0000
Received: from mail18-ch1 (localhost [127.0.0.1])	by mail18-ch1-R.bigfish.com
 (Postfix) with ESMTP id 22EB140012A;	Wed, 15 Jan 2014 13:31:43 +0000 (UTC)
Received: from mail18-ch1 (localhost.localdomain [127.0.0.1]) by mail18-ch1
 (MessageSwitch) id 1389792701140516_12741; Wed, 15 Jan 2014 13:31:41 +0000
 (UTC)
Received: from CH1EHSMHS027.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.241])	by mail18-ch1.bigfish.com (Postfix) with ESMTP id 130F2E00DB;
	Wed, 15 Jan 2014 13:31:41 +0000 (UTC)
Received: from moutng.kundenserver.de (212.227.126.187) by
 CH1EHSMHS027.bigfish.com (10.43.70.27) with Microsoft SMTP Server (TLS) id
 14.16.227.3; Wed, 15 Jan 2014 13:31:39 +0000
Received: from klappe2.localnet (HSI-KBW-085-216-031-165.hsi.kabelbw.de
 [85.216.31.165])	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP
 (Nemesis)	id 0LzWX0-1VGStv0Zgw-014Wpn; Wed, 15 Jan 2014 14:31:37 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: "prabhakar@freescale.com" <prabhakar@freescale.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Scott Wood
	<scottwood@freescale.com>
Subject: Re: [PATCH 1/2][v2] driver/memory:Move Freescale IFC driver to a
 common driver
Thread-Topic: [PATCH 1/2][v2] driver/memory:Move Freescale IFC driver to a
 common driver
Thread-Index: AQHPEeuHHUD451gZgEu9vznBaqSMeZqFyGGA
Date: Wed, 15 Jan 2014 13:31:35 +0000
Message-ID: <201401151431.35731.arnd@arndb.de>
References: <1389788003-25442-1-git-send-email-prabhakar@freescale.com>
In-Reply-To: <1389788003-25442-1-git-send-email-prabhakar@freescale.com>
Content-Language: en-US
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-AuthSource: BN1BFFO11FD012.protection.gbl
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: KMail/1.12.2 (Linux/3.8.0-22-generic; KDE/4.3.2; x86_64; ; )
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <779F9E42A65F414BBD9D493246EB4A4C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

On Wednesday 15 January 2014, Prabhakar Kushwaha wrote:
> Freescale IFC controller has been used for mpc8xxx. It will be used
> for ARM-based SoC as well. This patch moves the driver to driver/memory
> and fix the header file includes.
>
> Also remove module_platform_driver() and  instead call
> platform_driver_register() from subsys_initcall() to make sure this modul=
e
> has been loaded before MTD partition parsing starts.
>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

provided that you also move the binding from powerpc/fsl/ifc.txt to
memory/fsl-ifc.txt.



--_002_4523a32c7d304ef694929207d25b7732DM2PR03MB464namprd03pro_--
