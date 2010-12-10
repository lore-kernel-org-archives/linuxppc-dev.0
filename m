Return-Path: <r58472@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2DE6CB70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 19:02:28 +1100 (EST)
Received: from mail101-tx2 (localhost.localdomain [127.0.0.1])	by
	mail101-tx2-R.bigfish.com (Postfix) with ESMTP id C3DE31008591	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 10 Dec 2010 08:02:02 +0000 (UTC)
Received: from TX2EHSMHS029.bigfish.com (unknown [10.9.14.242])	by
	mail101-tx2.bigfish.com (Postfix) with ESMTP id A099040057	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 10 Dec 2010 08:02:02 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id oBA81xYo007140	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 01:02:00 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	oBA81xEc011674	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 02:01:59 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: RE: Problem with MPC8536 and external IRQs when using a loadable
	kernel module
Date: Fri, 10 Dec 2010 01:03:15 -0700
Message-ID: <3F607A5180246847A760FD34122A1E050372F9@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <1291950448.3574.5.camel@concordia>
References: <11BA25866A2E3A45A797B469B2344B3901554D3D@blademail.bladenetwork.net>	
	<1291937594.3523.20.camel@concordia>	
	<11BA25866A2E3A45A797B469B2344B3901554D94@blademail.bladenetwork.net>
	<1291950448.3574.5.camel@concordia>
From: Li Yang-R58472 <r58472@freescale.com>
To: <michael@ellerman.id.au>, Mark Pearson <Mark.Pearson@bladenetwork.net>
Cc: Jin Qing-B24347 <B24347@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pk9uIFRodSwgMjAxMC0xMi0wOSBhdCAxNzoyMCAtMDgwMCwgTWFyayBQZWFyc29uIHdyb3RlOg0K
Pj4gTWFnaWNhbCAtIHRoYW5rIHlvdSB2ZXJ5IHZlcnkgbXVjaC4gVGhlIHBhdGNoIGZpeGVzIHRo
ZSBwcm9ibGVtDQo+Pg0KPj4gUmVhbGx5IGFwcHJlY2lhdGUgdGhlIHF1aWNrIHJlc3BvbnNlIC0g
YW5kIEkgd291bGQgbmV2ZXIgaGF2ZSBmb3VuZCB0aGF0DQo+aW4gYSBtaWxsaW9uIHllYXJzLg0K
Pg0KPk5vIHdvcnJpZXMuDQo+DQo+TG9va3MgbGlrZSBzb21lb25lIHNob3VsZCBzZW5kIDc4ZTJl
NjhhMmIgdG8gdGhlIHN0YWJsZSBjcmV3LiBGU0wgZ3V5cz8NCg0KSSB0aGluayBpdCBoYXMgYWxy
ZWFkeSBiZWVuIHNlbnQgdG8gdGhlIHN0YWJsZUBrZXJuZWwub3JnLiAgTm90IHN1cmUgaWYgaXQg
aGFzIGJlZW4gaW5jbHVkZWQgdGhvdWdoLg0KDQotIExlbw0KDQo=
