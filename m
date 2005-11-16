Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23BE668725
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 17:17:23 +1100 (EST)
Received: from cpe-66-69-212-100.austin.res.rr.com ([66.69.212.100]
	helo=[192.168.1.100])
	by nommos.sslcatacombnetworking.com with esmtp (Exim 4.52)
	id 1EcGbe-0003BY-N6
	for linuxppc-embedded@ozlabs.org; Wed, 16 Nov 2005 00:17:18 -0600
Mime-Version: 1.0 (Apple Message framework v746.2)
References: <17274.51251.591579.8751@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6D755333-B416-4F31-A3A8-18ED308582E2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 16 Nov 2005 00:17:44 -0600
To: "linuxppc-embedded@ozlabs.org list" <linuxppc-embedded@ozlabs.org>
Subject: Fwd: powerpc.git tree now on kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

For those that only read linuxppc-embedded (and shame on you :)

- kumar

Begin forwarded message:

> From: Paul Mackerras <paulus@samba.org>
> Date: November 15, 2005 11:48:35 PM CST
> To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org, akpm@osdl.org
> Subject: powerpc.git tree now on kernel.org
>
> I have just created a git tree for ppc/powerpc patches that are
> candidates for 2.6.16.  The tree is at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
>
> Currently, besides the patches that are in the powerpc-merge.git tree,
> there are the following patches in there:
>
> Adrian Bunk:
>       PPC_PREP: remove unneeded exports
>
> Benjamin Herrenschmidt:
>       powerpc: Merge align.c (#2)
>
> David Gibson:
>       powerpc: Remove imalloc.h
>
> David Woodhouse:
>       syscall entry/exit revamp
>
> Kumar Gala:
>       powerpc: moved ipic code to arch/powerpc
>
> Michael Ellerman:
>       powerpc: Merge kexec
>
> Mike Kravetz:
>       Remove SPAN_OTHER_NODES config definition
>
> Although some of these patches may go to Linus before 2.6.15 is
> released, I won't be asking Linus to pull this tree directly, since it
> is likely to get a bit messy as patches are updated.  I expect that
> Andrew Morton will pull this tree periodically and include it in his
> -mm releases.
>
> Paul.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
