Return-Path: <sonic_amiga@rambler.ru>
Received: from mxc.rambler.ru (mxc.rambler.ru [81.19.66.31])
	by ozlabs.org (Postfix) with ESMTP id A006467A73
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2005 20:04:57 +1000 (EST)
Received: from mailc.rambler.ru (mailc.rambler.ru [81.19.66.27])
	by mxc.rambler.ru (Postfix) with ESMTP id 36894CDC0B
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2005 14:04:54 +0400 (MSD)
Received: from [192.168.0.39] (mailgw.cps.ru [62.117.96.149])
	(authenticated bits=0)
	by mailc.rambler.ru (8.12.10/8.12.10) with ESMTP id j2SA4qYl076890
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2005 14:04:53 +0400 (MSD)
Message-ID: <42485636.4000106@rambler.ru>
Date: Mon, 28 Mar 2005 14:08:38 -0500
From: Pavel Fedin <sonic_amiga@rambler.ru>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Again ISA DMA question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  Hello, all!

  In a source code or AROS operating system (http://www.aros.org) i 
found this comment:

  --- cut ---
     The older PReP machines have the DMA area limited to first 16MB of 
system
     memory. Therefore it is reasonable, to place the kernel at the end 
of DMA
     RAM. Both areas may be then easily separated.
  --- cut ---

  Does this mean that Linux has an option to limit DMA memory space to 
first 16 MB? PReP machines are fully supported i guess. Or not fully?

  Kind regards
