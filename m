Return-Path: <jarno.manninen@tut.fi>
Received: from kivi.ton.tut.fi (kivi.ton.tut.fi [193.166.235.14])
	by ozlabs.org (Postfix) with ESMTP id 8383367BBE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 22:40:57 +1000 (EST)
From: Jarno Manninen <jarno.manninen@tut.fi>
To: linuxppc-embedded@ozlabs.org
Subject: Re: root file system mounted via NFS - retry?
Date: Wed, 12 Apr 2006 15:40:41 +0300
References: <443CF3F8.408@imagemap.com>
In-Reply-To: <443CF3F8.408@imagemap.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604121540.41148.jarno.manninen@tut.fi>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 12 April 2006 15:35, Randy Smith wrote:

Hi,

If your system configuration is static why not just sleep in the bootloader 
for a while? U-boot has sleep command.

- Jarno

> Hello,
>
> I have a general question regarding having a root file system mounted
> via NFS.  Our system consists of a linux PC that acts as the NFS server
> and two embedded ppc boards running linux that mount their file systems
> via NFS.  The problem is that the embedded boards boot much faster than
> the PC, and when they attempt to mount the root file system, the NFS
> server is not up yet.  The embedded boards hang and it takes quite a
> long time before the watchdog timer reboots them.  The next time round,
> they come up just fine.
> What I would like for them to do is keep trying until the NFS server
> appears and then continue to boot.
>
> We are running DENX's ELDK 2.4.25 kernel on the ppc boards and I know
> that for some linux releases, one may add values for timeo and retrans
> on the boot command line in the NFSROOT= command.  Can anyone tell me if
> they are valid for this release of the kernel?  Or if there is another
> way to accomplish this?
>
> Thanks,
>
> -Randy Smith
> Software Engineer
> ImageMap, Inc.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
