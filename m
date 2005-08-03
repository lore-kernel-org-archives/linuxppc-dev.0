Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id BEA2067E79
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 15:48:46 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	j735ug9v011415
	for <linuxppc-embedded@ozlabs.org>; Tue, 2 Aug 2005 22:56:42 -0700 (MST)
Received: from [192.168.123.102] ([10.214.72.39])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j735q4jb017328
	for <linuxppc-embedded@ozlabs.org>; Wed, 3 Aug 2005 00:52:05 -0500 (CDT)
Mime-Version: 1.0 (Apple Message framework v733)
References: <17136.13558.773102.465379@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1C264F1A-9D11-447C-8F7E-8B31E1788C4F@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 3 Aug 2005 00:48:48 -0500
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Fwd: Merging ppc32 and ppc64
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

FYI.  For those not subscribed to linuxppc-dev or linuxppc64-dev.

- kumar

Begin forwarded message:

> From: "Paul Mackerras" <paulus@samba.org>
> Date: August 2, 2005 10:07:34 PM CDT
> To: <linuxppc-dev@ozlabs.org>, <linuxppc64-dev@ozlabs.org>
> Subject: Merging ppc32 and ppc64
>
>
> At OLS I discussed the idea of merging the ppc32 and ppc64
> architectures in the Linux kernel with various ppc32 and ppc64 kernel
> hackers and users.  There was broad agreement that this would be a
> good thing to do, so we are going to go ahead and do it.
>
> The plan is to create include/asm-powerpc and arch/powerpc directories
> for the merged architecture and move stuff in there as it gets
> merged.  The existing ppc32 and ppc64 directories will stay around
> until they are no longer useful.  The intention is not to break
> anything that currently works; however, we do not plan to move unused
> and unmaintained platforms into the merged architecture.
>
> The advantage of merging is that it will reduce the maintenance effort
> and reduce the instances where a common bug gets fixed in one
> architecture but not the other.  It will also make it easier to
> support 64-bit embedded systems as they become more common.
>
> I don't see the merge as changing the actual code that gets executed
> on any given platform very much, except in one respect: we are going
> to standardize on a flattened device tree as the way that information
> about the platform gets passed from the boot loader to the kernel.
>
> Comments? Flames? :)
>
> Paul.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
