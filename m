Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 31F78DDF13
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2007 19:02:13 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l25828l1028974
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2007 01:02:08 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l25826lL014021
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2007 02:02:07 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Real time clock support in arch/powerpc
Date: Mon, 5 Mar 2007 16:02:05 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6216@zch01exm23.fsl.freescale.net>
In-Reply-To: <20070305032307.GB31417@localhost.localdomain>
References: <20070305032307.GB31417@localhost.localdomain>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: <mgreer@mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Is there any plan to add real time clock support in arch/powerpc?
I can find the support in arch/ppc/syslib/todc_time.c
Roy
