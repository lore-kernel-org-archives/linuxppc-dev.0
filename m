Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 854B3DDF2B
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Sep 2007 00:32:26 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7VEWNwT008608
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 10:32:23 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7VEWHts269606
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 08:32:19 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7VEWD59017333
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 08:32:13 -0600
Date: Fri, 31 Aug 2007 09:32:11 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Hommel, Thomas (GE Indust, GE Fanuc)" <Thomas.Hommel@gefanuc.com>
Subject: Re: Section mismatch in 2.6.23-rc4
Message-ID: <20070831093211.3ad97687@weaponx.rchland.ibm.com>
In-Reply-To: <62DDBB9E5E23CC4A929EE46F9427CEAF295F6F@BUDMLVEM04.e2k.ad.ge.com>
References: <62DDBB9E5E23CC4A929EE46F9427CEAF295F6F@BUDMLVEM04.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 31 Aug 2007 14:25:34 +0200
"Hommel, Thomas (GE Indust, GE Fanuc)" <Thomas.Hommel@gefanuc.com>
wrote:

> 
> When compiling a kernel, I get the warnings below. 
> I am using ARCH=powerpc and 'make mpc8641_hpcn_defconfig', 'make
> uImage'. This didn't appear in 2.6.22, but in
> arch/powerpc/kernel/head_32.S and setup_32.c, the section info
> apparently didn't change. 

Kumar Galak has a patch series that clean these warnings up for ppc32.

josh
