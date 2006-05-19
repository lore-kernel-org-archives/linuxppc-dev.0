Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (unknown [192.88.158.103])
	by ozlabs.org (Postfix) with ESMTP id AE95867A6C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 11:46:01 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k4J21rFv010696
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 19:01:53 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k4J1jlNO021413
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 20:45:48 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673062C0ED4@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Fri, 19 May 2006 09:45:45 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Alexandre.Bounine@tundra.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Zang Roy-r61911 writes:
> 
> > I can migrate my code to embedded6xx technically. In fact, 
> > I can move it into anywhere in the arch/powerpc/platforms. 
> > While for mpc7448hpc2(taiga) board, it is not a embedded 
> > application board. It is a high performance server! It seems
> > odd to put code there :). What's your opinion?
> 
> What sort of machine(s) is this board used in?  Or what machines will
> it be in?
> 
> Paul.
> 
mpc7448hpc2 (taiga) board is a high-performance PowerPC 
server reference design,which is optimized for high speed throughput
between the processor (mpc7448 or 7447A) and the memory, disk drive 
and Ethernet port subsystems.

mpc7448hpc2 (taiga) is designed to the micro-ATX chassis, 
allowing it to be used in 1U or 2U rack-mount chassis' , as well as 
in standard ATX/Micro-ATX chassis.

Roy
