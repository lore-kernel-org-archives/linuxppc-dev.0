Return-Path: <dostrow@gentoo.org>
From: Daniel Ostrow <dostrow@gentoo.org>
To: panto@intracom.gr
Content-Type: text/plain
Date: Tue, 27 Sep 2005 11:43:46 -0400
Message-Id: <1127835826.7811.27.camel@Memoria.anyarch.net>
Mime-Version: 1.0
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: Starting the arch/powerpc merge
Reply-To: dostrow@gentoo.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>Pantelis Antoniou writes:
>
>> Count me in too; using a 970 in 32 bit mode, because of gentoo X.org
>> problems in 64 bit mode.
>
>I'm using an X.org server on a ppc64 kernel, and it all works,
>including DRI.  Both 32-bit and 64-bit X server and clients work.  We
>now have the 32-bit ioctl compatibility sorted out in the kernel DRM.
>So I don't think X is a reason to run a 32-bit kernel any more.
>
>What X.org problems do you see with a 64-bit kernel?
>
>Paul.

Speaking as a member of the Gentoo/PPC64 team I'm also curious what
issues you are having...the only open issues that I am aware of have to
do with the recent r7 X.org prereleases...both modular and monolithic.
If that is what you are talking about then yeah there are issues...but
more then likely they are on the X.org side not the kernels. Anything in
the 6.8.2 range (which is what is stable) has been working fine for a
long long time under a pure 64-bit env.

Thanks,

-- 
Daniel Ostrow
Gentoo Foundation Board of Trustees
Gentoo/{PPC,PPC64,DevRel}
dostrow@gentoo.org
