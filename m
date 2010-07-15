Return-Path: <R63238@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 18C50B7083
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 09:30:53 +1000 (EST)
Received: from mail145-va3 (localhost.localdomain [127.0.0.1])	by
	mail145-va3-R.bigfish.com (Postfix) with ESMTP id 02928D20678	for
	<linuxppc-dev@ozlabs.org>; Thu, 15 Jul 2010 23:15:45 +0000 (UTC)
Received: from VA3EHSMHS017.bigfish.com (unknown [10.7.14.243])	by
	mail145-va3.bigfish.com (Postfix) with ESMTP id DB71A135804D	for
	<linuxppc-dev@ozlabs.org>; Thu, 15 Jul 2010 23:15:44 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6FNFRC8021332	for
	<linuxppc-dev@ozlabs.org>; Thu, 15 Jul 2010 16:15:37 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o6FNSOwW008464	for <linuxppc-dev@ozlabs.org>;
	Thu, 15 Jul 2010 18:28:25 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: RE: [PATCH] powerpc: Fix GENERIC_ISA_DMA dependency
Date: Fri, 16 Jul 2010 07:15:20 +0800
Message-ID: <50260780A060C94D9E98AC2670936D600824E0@zch01exm21.fsl.freescale.net>
In-Reply-To: <20100715173816.GA17810@oksana.dev.rtsoft.ru>
References: <20100715173816.GA17810@oksana.dev.rtsoft.ru>
From: Liu Dave-R63238 <r63238@freescale.com>
To: "Anton Vorontsov" <avorontsov@mvista.com>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiBPbiBQb3dlclBDIHdlIHNob3VsZCBhbHdheXMgdXNlIGdlbmVyaWMgSVNBIERNQSBBUEkgaW1w
bGVtZW50YXRpb24NCj4gYXMgdGhlcmUgaXMgc2ltcGx5IG5vIG90aGVyIGltcGxlbWVudGF0aW9u
IGV4aXN0Lg0KPiANCj4gV2l0aG91dCB0aGlzIHBhdGNoLCB0aGUgZm9sbG93aW5nIGJ1aWxkIGVy
cm9yIHBvcHMgdXA6DQo+IA0KPiAgIHNvdW5kL2J1aWx0LWluLm86IEluIGZ1bmN0aW9uICdzbmRf
ZG1hX3BvaW50ZXInOg0KPiAgICgudGV4dCsweDc0YWUpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRv
ICdkbWFfc3Bpbl9sb2NrJw0KPiAgIC4uLg0KPiAgIG1ha2U6ICoqKiBbLnRtcF92bWxpbnV4MV0g
RXJyb3IgMQ0KPiANCj4gVGhpcyBpcyBQUENfODV4eCwgU01QIGFuZCBzb21lIHNvdW5kIGRyaXZl
cnMgc2V0IHRvID15Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW50b24gVm9yb250c292IDxhdm9y
b250c292QG12aXN0YS5jb20+DQoNCkFja2VkLWJ5OiBEYXZlIExpdSA8ZGF2ZWxpdUBmcmVlc2Nh
bGUuY29tPg0KDQpJIGhhcHBlbmVkIHRoaXMgaXNzdWUgd2hlbiBJIGRldmVsb3BlZCBQMTAyMkRT
IEJTUC4NCg==
