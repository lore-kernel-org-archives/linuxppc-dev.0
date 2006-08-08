Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 776FC67A3A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 17:06:18 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7876GSR025442
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2006 00:06:16 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7876AoO009040
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2006 02:06:12 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc: Add tsi108/9 and new hardware interface to mpic
Date: Tue, 8 Aug 2006 15:06:08 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E19D3C5@zch01exm23.fsl.freescale.net>
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E0456D0@zch01exm23.fsl.freescale.net>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Stewart Katherine-ra4863 <K.Stewart@freescale.com>,
	Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The patch add new hardware information table for mpic. This=20
> enables mpic
> code=20
> to deal with OpenPIC controller with hardware behavior difference.
> Add TSI108/109 PIC hardware information table.  The=20
> Tsi108/109 PIC looks
> like=20
> standard OpenPIC but, in fact, is different in registers mapping and
> behavior.

Hi, Paul
	How about the status of this patch?
	How about a new hardware entry for mpic?
	Where is Ben?
	I am still waiting for the feedback.
Roy
