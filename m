Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 801B1DDD0A
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 09:54:18 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l1QMsE8b023127
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 15:54:14 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1QMsEY8017672
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 16:54:14 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: #cpus property
Date: Mon, 26 Feb 2007 15:54:12 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302AA0181@az33exm25.fsl.freescale.net>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Anyone know the origin of the #cpus property that seems to be in most of
the DTS files.  It seems to be documented nowhere.

It's obviously describing how many cpus exist.  However, greping the
kernel source turns up no references to it.

Is it supposed to be required for all cpus nodes?  Are there plans to
actually use it?

Stuart
