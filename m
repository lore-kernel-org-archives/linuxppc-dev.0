Message-Id: <5.1.0.14.2.20020409002318.00aff420@pop.prodigy.net>
Date: Tue, 09 Apr 2002 00:29:06 -0700
To: "sanjay k k" <fren00@rediffmail.com>
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: Anybody able to build linux kernel for PPC440?
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020409051614.7827.qmail@mailFA3.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sanjay,

At 10:16 PM 4/8/2002, you wrote:
>Anybody is able build the linux kernel for PPC440 using
>linux_2_4_devel tree. I tried but i got few unresolved error?

I did it last Friday, just after Matt had pushed his changes.

There were minor problems during the compilation of do_mounts.c and nfsctl.c -
just add missing include of <linux/init.h>

Take care,

  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
