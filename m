Return-Path: <B48286@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0102.outbound.protection.outlook.com [207.46.100.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A70C11A03C3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 13:27:45 +1100 (AEDT)
From: Hou Zhiqiang <B48286@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com"
 <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "Harninder
 Rai" <harninder.rai@freescale.com>, Lian M.H. <Minghuan.Lian@freescale.com>,
 Hu Vincent <Mingkai.Hu@freescale.com>
Subject: RE: [V2,1/2] powerpc/fsl: Add PCI node in device tree of bsc9132qds
Date: Mon, 19 Oct 2015 02:12:32 +0000
Message-ID: <CY1PR0301MB078002CFBCD517A488933DF18B3A0@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1444986071-27317-1-git-send-email-B48286@freescale.com>
 <20151017013337.GA22242@home.buserror.net>
In-Reply-To: <20151017013337.GA22242@home.buserror.net>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogMjAxNcTqMTDUwjE3yNUgOTozNA0KPiBUbzogSG91IFpoaXFpYW5nLUI0ODI4
Ng0KPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGdhbGFrQGtlcm5lbC5jcmFz
aGluZy5vcmc7DQo+IGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZzsgcGF1bHVzQHNhbWJhLm9yZzsg
bXBlQGVsbGVybWFuLmlkLmF1Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgcm9iaCtk
dEBrZXJuZWwub3JnOyBwYXdlbC5tb2xsQGFybS5jb207DQo+IG1hcmsucnV0bGFuZEBhcm0uY29t
OyBpamMrZGV2aWNldHJlZUBoZWxsaW9uLm9yZy51azsgUmFpIEhhcm5pbmRlci1CMDEwNDQ7DQo+
IExpYW4gTWluZ2h1YW4tQjMxOTM5OyBIdSBNaW5na2FpLUIyMTI4NA0KPiBTdWJqZWN0OiBSZTog
W1YyLDEvMl0gcG93ZXJwYy9mc2w6IEFkZCBQQ0kgbm9kZSBpbiBkZXZpY2UgdHJlZSBvZg0KPiBi
c2M5MTMycWRzDQo+IA0KPiBPbiBGcmksIE9jdCAxNiwgMjAxNSBhdCAwNTowMToxMFBNICswODAw
LCBaaGlxaWFuZyBIb3Ugd3JvdGU6DQo+ID4gRnJvbTogSGFybmluZGVyIFJhaSA8aGFybmluZGVy
LnJhaUBmcmVlc2NhbGUuY29tPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFybmluZGVyIFJh
aSA8aGFybmluZGVyLnJhaUBmcmVlc2NhbGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pbmdo
dWFuIExpYW4gPE1pbmdodWFuLkxpYW5AZnJlZXNjYWxlLmNvbT4NCj4gPiBDaGFuZ2UtSWQ6IEk0
MzU1YWRkNGE5MmQxZmNmNTE0ODQzYWVhNWVjYWRkMmUyNTE3OTY5DQo+ID4gUmV2aWV3ZWQtb246
IGh0dHA6Ly9naXQuYW0uZnJlZXNjYWxlLm5ldDo4MTgxLzI0NTQNCj4gPiBSZXZpZXdlZC1ieTog
WmFuZyBUaWVmZWktUjYxOTExIDx0aWUtZmVpLnphbmdAZnJlZXNjYWxlLmNvbT4NCj4gPiBSZXZp
ZXdlZC1ieTogS3VzaHdhaGEgUHJhYmhha2FyLUIzMjU3OSA8cHJhYmhha2FyQGZyZWVzY2FsZS5j
b20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZsZW1pbmcgQW5kcmV3LUFGTEVNSU5HIDxBRkxFTUlOR0Bm
cmVlc2NhbGUuY29tPg0KPiA+IFRlc3RlZC1ieTogRmxlbWluZyBBbmRyZXctQUZMRU1JTkcgPEFG
TEVNSU5HQGZyZWVzY2FsZS5jb20+DQo+IA0KPiBBZ2FpbjoNCj4gDQo+IEdldCByaWQgb2YgdGhl
IGdlcnJpdCBzdHVmZi4gIEFuZCB3aGVyZSBpcyB5b3VyIHNpZ25vZmY/DQoNCk9rLg0KDQpUaGFu
a3MsDQpaaGlxaWFuZw0K
