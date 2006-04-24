Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id CE214679EA
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 04:43:27 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k3OJ2HDZ003221
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 12:02:17 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k3OIsMkf004783
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 13:54:22 -0500 (CDT)
Subject: 85xx FDT updates?
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1145900516.4251.18.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Mon, 24 Apr 2006 12:41:56 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

OK, so what is the deal with the 85xx patches
that have been submitted for more FDT support?
I get a variety of mixed stories, message and
vague comments.  I want some facts and direction.

Can anyone verify, validate, refute, deny or
support any of these statements?  Not trying to
be mean, point fingers or sound negative here,
I'm just trying to pinpoint the apparent log-jam.


1. The 85xx patches that Andy submitted, that
   have been pulled into Kumar's 85xx git tree
   are going to sit there until further patches
   are submitted that _remove_all_85xx_support_
   from the arch/ppc tree as well.

2. The same patches are going to sit in Kumar's
   tree until 8560 patches with support for CPM
   are released and all 85xx ports appear fully
   and completely in arch/powerpc.  BTW, CPM is
   waiting on approval of Vitaly's CPM proposal
   for OF FDT support.

3. Statements 1 and 2 combined.

4. The same 85xx patches have just slipped through
   some mental crack and simply need to be pulled,
   re-applied, re-drafted, re-submitted.  Oops, sorry.
   The action item is in _________'s lap.

5. There was an unresolved comment/issue that
   FSL still needs to address.  BTW, that issue
   is ________.

6. We are waiting on something else and that
   item is _______.

7. You know, you really need to address the _other_
   85xx ports (such as TQMs) as well.  Can you
   please do something about those as well?

8. These Linux patches aren't going to be picked
   up until the corresponding U-Boot patches are
   picked up as well.

Thanks,
jdl
