Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1C3161007D2
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 12:40:20 +1100 (EST)
Received: from mail29-va3 (localhost.localdomain [127.0.0.1])	by
	mail29-va3-R.bigfish.com (Postfix) with ESMTP id C34CD94020A	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 01:40:16 +0000 (UTC)
Received: from VA3EHSMHS017.bigfish.com (unknown [10.7.14.237])	by
	mail29-va3.bigfish.com (Postfix) with ESMTP id 7C457C9804D	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 01:40:16 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9E1eChL025420	for <linuxppc-dev@ozlabs.org>;
	Wed, 13 Oct 2010 18:40:12 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9E1eCVF012071	for <linuxppc-dev@ozlabs.org>;
	Wed, 13 Oct 2010 20:40:12 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/2] [v2] powerpc/85xx: add DIU support to the Freecale
	P1022DS reference board
Date: Wed, 13 Oct 2010 18:39:58 -0700
Message-ID: <5610599F537DD74A8D1F5CC946A75073034793B7@az33exm25.fsl.freescale.net>
In-Reply-To: <C692EF20-D7BD-4381-93F8-D1AA58BA89C4@freescale.com>
References: <1286480203-28227-1-git-send-email-timur@freescale.com>
	<1286480203-28227-2-git-send-email-timur@freescale.com>
	<C692EF20-D7BD-4381-93F8-D1AA58BA89C4@freescale.com>
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Gala Kumar-B11780 <kumar.gala@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

S3VtYXIgR2FsYSB3cm90ZToNCj4+ID4gIGFyY2gvcG93ZXJwYy9jb25maWdzL21wYzg1eHhfZGVm
Y29uZmlnICAgICB8ICAgIDMgKw0KPj4gPiAgYXJjaC9wb3dlcnBjL2NvbmZpZ3MvbXBjODV4eF9z
bXBfZGVmY29uZmlnIHwgICAgMyArDQo+PiA+ICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgv
cDEwMjJfZHMuYyAgICAgfCAgMjEzICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4+ID4g
IDMgZmlsZXMgY2hhbmdlZCwgMjE3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IEkg
ZHJvcHBlZCB0aGlzIGJlY2F1c2Ugb2YgY2hpY2tlbi9lZ2cgaXNzdWUgd2l0aCBndXRzLmgNCg0K
SWYgeW91IHB1bGwgZnJvbSBhbHNhLW5leHQsIGl0IHNob3VsZCByZXNvbHZlIHRoYXQuDQoNCkVp
dGhlciB0aGF0LCBvciBhc2sgdGhlIGFsc2EgZ3V5cyB0byBhcHBseSB0aGlzIHBhdGNoIGluc3Rl
YWQuDQoNCi0tIA0KVGltdXIgVGFiaQ0KTGludXgga2VybmVsIGRldmVsb3Blcg0K
