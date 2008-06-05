Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F3BA9DDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jun 2008 12:31:38 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m552VZeM024539
	for <linuxppc-embedded@ozlabs.org>; Wed, 4 Jun 2008 22:31:35 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m552VYow079234
	for <linuxppc-embedded@ozlabs.org>; Wed, 4 Jun 2008 20:31:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m552VYUj032646
	for <linuxppc-embedded@ozlabs.org>; Wed, 4 Jun 2008 20:31:34 -0600
Date: Wed, 4 Jun 2008 21:31:23 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: - Reyneke <reynekejunk@hotmail.com>
Subject: Re: FP and signal 4
Message-ID: <20080604213123.4e53f813@zod.rchland.ibm.com>
In-Reply-To: <BAY101-W2A5F2B80B271BD10DE9BBBEB50@phx.gbl>
References: <BAY101-W2A5F2B80B271BD10DE9BBBEB50@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 4 Jun 2008 14:43:48 +0000
- Reyneke <reynekejunk@hotmail.com> wrote:

> 
> Hi all,
> 
> Has anyone come across any floating point issues in the new powerpc kernel branch with regards to 44x? I'm seeing programs (i.e. init/busybox) generating signal 4 (illegal instruction) exceptions. If I compile a 2.6.25 kernel with the CONFIG_MATH_EMULATION option set, then everything works OK. 

I've not seen that.

> Using a 440EPx (has a onchip FPU) with the ELDK 4.0 ppc_4xxFP toolchain for all apps/kernel/fs. 

440EPx should get the FPU enabled at runtime.  We use a virtual PVR to
do the APU/FPU init.  What does your cpu node look like in your DTS
file for your board?

josh
