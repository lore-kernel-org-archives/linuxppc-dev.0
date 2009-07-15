Return-Path: <Rupesh.Kumar@Lntemsys.com>
Received: from mail87.messagelabs.com (mail87.messagelabs.com [216.82.250.19])
	by bilbo.ozlabs.org (Postfix) with SMTP id 0D916B7083
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 00:49:41 +1000 (EST)
To: linuxppc-dev@lists.ozlabs.org
Subject: booting MPC8313 based board with yaffs2 RFS
MIME-Version: 1.0
Message-ID: <OFB2EFC395.7BD1B8AD-ON652575F4.00512780-652575F4.00513235@lntemsys.com>
From: Rupesh Kumar <Rupesh.Kumar@Lntemsys.com>
Date: Wed, 15 Jul 2009 20:28:45 +0530
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi
I am using MPC8313 board which is currently booting with JFFS2 root file 
system. 
I am using linux kernel version 2.6.23 from FreeScale's LTIB for MPC8313. 

As, I want it to boot with YAFFS2 root file system, I did compile kernel 
with yaffs2 support, craeted yaffs2 rootfile system and passed yaffs2 
partiton of nand in bootargs. However it didnot work.


If any one has done it successfully, can please share the steps to be 
followed ?

Thanks
Rupesh
