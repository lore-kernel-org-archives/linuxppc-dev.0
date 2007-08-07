Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EB2EDDEB9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 05:29:09 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l77IMePK008238
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Aug 2007 14:22:40 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l77JT6HY258724
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Aug 2007 13:29:06 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l77JT5oE007391
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Aug 2007 13:29:05 -0600
Date: Tue, 7 Aug 2007 14:29:04 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Michael Brian Willis <willis@arlut.utexas.edu>
Subject: Re: Fedora 7 on a non FPU system
Message-ID: <20070807142904.77abf384@weaponx.rchland.ibm.com>
In-Reply-To: <1186508561.5592.26.camel@louie>
References: <20070313043050.GB82243@server.idefix.lan>
	<513703.69187.qm@web302.biz.mail.mud.yahoo.com>
	<20070314043305.GB27011@server.idefix.lan>
	<20070314065411.GD14658@moe.telargo.com>
	<1186508561.5592.26.camel@louie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 07 Aug 2007 12:42:41 -0500
Michael Brian Willis <willis@arlut.utexas.edu> wrote:

> Hello, 
> 
> I'm trying to install a Fedora 7 Root File System on an MPC8540 based
> embedded system with a Denx 2.6.21 kernel. I have read the Denx
> Application note located at: 
> http://www.denx.de/wiki/DULG/AN2007_03_InstallFC7OnSequoia. 
> 
> However this App. Note says that the instructions apply only to
> processors that have a full Floating Point Unit (FPU). My processor does
> not have an FPU and I believe that this is causing some system hangs. 
> 
> Has anybody every successfully installed Fedora(or another major distro)
> on a non-FPU system? Or, does anybody know what is needed to get it
> working properly on a non FPU system? 

CONFIG_MATH_EMULATION in the kernel will emulate floating point
instructions. Try that.

josh
