Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 704EA68A51
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 00:06:00 +1100 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Jan 2006 09:45:21 +0100."
	<200601090945.22564.david.jander@protonic.nl>
Date: Mon, 09 Jan 2006 14:05:58 +0100
Sender: wd@denx.de
Message-Id: <20060109130558.9257A353A66@atlas.denx.de>
Cc: HappyPhot <happyphot@gmail.com>, linuxppc-embedded@ozlabs.org
Subject: Re: VFS: Cannot open root device "31:03" or unknown-block(31,3) 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200601090945.22564.david.jander@protonic.nl> you wrote:
>
> ELDK-3.1.1 has a glibc compiled with support of a certain version of the 
> kernel (I guess it's 2.4.xx), so newer kernels might run (because they are 

They do run.

> obviously backwards compatible), but some features of 2.6 cannot be used 
> (e.g. support for the latest syscalls, different HZ, etc...)

You can also change HZ if you like.

> A second issue is the boot procedure. If you are a beginner with linux, you'd 
> probably start booting from NFS root as it gets installed in the ELDK/ppc_xxx 
> directory. That probably won't work very well with latest 2.6 kernels (device 
> files missing, sysfs not mounted, shmfs has different name, etc...)

You can (mis-) configre  a  2.4  kernel  too.  Using  a  sane  kernel
configuration  ther  ewill  be  no  problems. We have been using ELDK
3.1.1 for a long time ourself developing 2.6 kernel code.

> > C++  programs  and  with  any version of the kernel tree (at least in
> > theory; very recent version s of the Linux kernel [ > 2.6.14]  cannot
> > be compiled with ELDK 3.1.x any more, but this is a different issue).
> 
> See what I mean? HappyPhot did just that: compile 2.6.14.2 with ELDK 3.1.1!!!

I wrote "> 2.6.14"; 2.6.14.2 is just a branch off 2.6.14 and is  fine
AFAICT.

> > The ELDK supports *any* kernel version.
> 
> Ok, let's talk about "recommended" kernel then. I would never recommend 

There is no recommended kernel version. On contrary,  we  take  great
efforts  to keep the ELDK independent of speicfic kernelk versions as
far as possible.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Quantum particles: The dreams that stuff is made of.
