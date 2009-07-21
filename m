Return-Path: <LeoLi@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D772AB7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jul 2009 19:32:27 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 65782DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2009 19:32:25 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n6L9W8dn021427
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2009 02:32:22 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n6L9W6Ff022654
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2009 04:32:07 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: DMA Engine on MPC8270
Date: Tue, 21 Jul 2009 17:32:06 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED53F231@zch01exm26.fsl.freescale.net>
In-Reply-To: <4A65887B.8090103@embedded-sol.com>
References: <4A65887B.8090103@embedded-sol.com>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: "Felix Radensky" <felix@embedded-sol.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Hi,
>
>Can Freescale DMA engine driver can be used on MPC2870 ?

No, the driver is only used on 83xx and 85xx cpus.

- Leo
