Return-Path: <tallam.sreen@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by ozlabs.org (Postfix) with ESMTP id 92891DE14B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Apr 2008 02:53:32 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so101629wri.3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Apr 2008 09:53:31 -0700 (PDT)
Message-ID: <5b1d25eb0804100953u38f514dblaccbb3477c532b23@mail.gmail.com>
Date: Thu, 10 Apr 2008 09:53:30 -0700
From: "Sreen Tallam" <tallam.sreen@gmail.com>
To: "Sebastian Siewior" <linuxppc-embedded@ml.breakpoint.cc>
Subject: Re: Kernel Panic - not syncing: Attempted to kill init!
In-Reply-To: <20080410085030.GA27907@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <5b1d25eb0804091907n7b1d6faewf66b5d664e40c115@mail.gmail.com>
	<20080410085030.GA27907@Chamillionaire.breakpoint.cc>
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

Hi Sebastian,

Thank you for looking into this issue.
But I am not using udev. And my /dev is empty, there is no devices in there.

Any more hints on this. I would appreciate your follow up.

Thanks,
Sreen

On Thu, Apr 10, 2008 at 1:50 AM, Sebastian Siewior
<linuxppc-embedded@ml.breakpoint.cc> wrote:
> * Sreen Tallam | 2008-04-09 19:07:01 [-0700]:
>
>
>  >VFS: Mounted root (jffs2 filesystem) readonly.
>  >Freeing unused kernel memory: 156k init
>  >Warning: unable to open an initial console.
>  >init/main.c -- 819
>  >init/main.c -- 821
>  >init/main.c -- 844
>  >init/main.c -- 704 -- /sbin/tallam_init<0>Kernel panic - not syncing:
>  >Attempted to kill init!
>  >Call Trace:
>  >[C3FE7E60] [C0006D98]  (unreliable)
>  >[C3FE7EA0] [C001F150]
>  >[C3FE7EF0] [C0023630]
>  >[C3FE7F30] [C0023734]
>  >[C3FE7F40] [C000DBC0]
>  > <0>Rebooting in 180 seconds..
>  >
>
>  This looks like you are missing /dev/console and probably /dev/null. You
>  need atleast those two nodes in your rootfs if you are using udev. You
>  will need a static /dev if you don't use udev/mdev.
>
>  >Thanks,
>  >Sreen
>  Sebastian
>
