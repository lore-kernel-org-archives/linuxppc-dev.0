Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 88B29B7D4C
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 15:19:55 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o455JbHE000545
	for <linuxppc-dev@ozlabs.org>; Tue, 4 May 2010 22:19:47 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o455TJKA012454
	for <linuxppc-dev@ozlabs.org>; Wed, 5 May 2010 00:29:20 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: Page fault on vmalloc'ed memory
Date: Wed, 5 May 2010 13:19:33 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED0183AF33@zch01exm26.fsl.freescale.net>
From: "Li Yang-R58472" <r58472@freescale.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgYWxsLA0KDQpJIGdvdCBhIHdlaXJkIHBhZ2UgZmF1bHQgb29wcyBvbiB2bWFsbG9jJ2VkIGFy
ZWEuICBEaWdnaW5nIGludG8gdGhlIHBvd2VycGMgZG9fcGFnZV9mYXVsdCgpLCBJIGZvdW5kIHRo
ZXJlIGlzIG5vIGhhbmRsaW5nIG9mIGFkZHJlc3MgaW4ga2VybmVsIHNwYWNlIHVubGlrZSB0aGUg
eDg2IGNvdW50ZXIgcGFydC4gIERvZXMgYW55IG9uZSBrbm93IGhvdyB3ZSBkZWFsIHdpdGggdGhl
IHZtYWxsb2MnZWQgYXJlYSBvbiBwb3dlcnBjPyAgVGhhbmtzIGEgbG90Lg0KDQotIExlbw0K
