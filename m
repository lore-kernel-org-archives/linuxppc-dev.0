Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71510DDF6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Apr 2008 18:50:34 +1000 (EST)
Date: Thu, 10 Apr 2008 10:50:30 +0200
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: Sreen Tallam <tallam.sreen@gmail.com>
Subject: Re: Kernel Panic - not syncing: Attempted to kill init!
Message-ID: <20080410085030.GA27907@Chamillionaire.breakpoint.cc>
References: <5b1d25eb0804091907n7b1d6faewf66b5d664e40c115@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <5b1d25eb0804091907n7b1d6faewf66b5d664e40c115@mail.gmail.com>
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

* Sreen Tallam | 2008-04-09 19:07:01 [-0700]:

>VFS: Mounted root (jffs2 filesystem) readonly.
>Freeing unused kernel memory: 156k init
>Warning: unable to open an initial console.
>init/main.c -- 819
>init/main.c -- 821
>init/main.c -- 844
>init/main.c -- 704 -- /sbin/tallam_init<0>Kernel panic - not syncing:
>Attempted to kill init!
>Call Trace:
>[C3FE7E60] [C0006D98]  (unreliable)
>[C3FE7EA0] [C001F150]
>[C3FE7EF0] [C0023630]
>[C3FE7F30] [C0023734]
>[C3FE7F40] [C000DBC0]
> <0>Rebooting in 180 seconds..
>

This looks like you are missing /dev/console and probably /dev/null. You
need atleast those two nodes in your rootfs if you are using udev. You
will need a static /dev if you don't use udev/mdev.

>Thanks,
>Sreen
Sebastian
