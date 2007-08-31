Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0BE5CDDF6C
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Sep 2007 00:41:56 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l7VDYcva018036
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 09:34:38 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7VEfrkf420672
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 08:41:53 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7VEfrXU007953
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 08:41:53 -0600
Received: from weaponx.rchland.ibm.com (weaponx.rchland.ibm.com [9.10.86.36])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l7VEfq8E007935
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 08:41:53 -0600
Date: Fri, 31 Aug 2007 09:41:52 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: <linuxppc-dev@ozlabs.org>
Subject: Re: Section mismatch in 2.6.23-rc4
Message-ID: <20070831094152.06f99734@weaponx.rchland.ibm.com>
In-Reply-To: <20070831093211.3ad97687@weaponx.rchland.ibm.com>
References: <62DDBB9E5E23CC4A929EE46F9427CEAF295F6F@BUDMLVEM04.e2k.ad.ge.com>
	<20070831093211.3ad97687@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 31 Aug 2007 09:32:11 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Fri, 31 Aug 2007 14:25:34 +0200
> "Hommel, Thomas (GE Indust, GE Fanuc)" <Thomas.Hommel@gefanuc.com>
> wrote:
> 
> > 
> > When compiling a kernel, I get the warnings below. 
> > I am using ARCH=powerpc and 'make mpc8641_hpcn_defconfig', 'make
> > uImage'. This didn't appear in 2.6.22, but in
> > arch/powerpc/kernel/head_32.S and setup_32.c, the section info
> > apparently didn't change. 
> 
> Kumar Galak has a patch series that clean these warnings up for ppc32.

Er, that would be Kumar Gala.  There I go, defaulting to IRC nicks
again.

josh
