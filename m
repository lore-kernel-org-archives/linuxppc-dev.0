Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D6683DDE22
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 14:50:39 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l183oZsI023179
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 20:50:36 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l183oXAQ008832
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 21:50:34 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [patch][0/5] powerpc V2 : Add support to fully comply with IEEE-754
	standard
Date: Thu, 8 Feb 2007 11:50:31 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E8B7DFC@zch01exm20.fsl.freescale.net>
In-Reply-To: <B20A9346-C296-4570-AD4A-E9412C591F7B@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

These are the re-sent patches to add support to fully comply with
IEEE-754 standard for E500/E500v2 core when hardware floating
point compiling is used. Comparison with last patches I've submitted,
the following points was changed:

1. Add a rounding exception handler, to handle the exceptions that
would occur when rounding towards +Inf/-Inf

2. Using the existing exception entering/returning routine, and get the
exception
instructions from regs->nip instead of reading from SRR0

Thank you all for the comments you gave to me!

B.R.
Ebony
