Message-Id: <5.1.0.14.2.20030715092123.02ef0d20@mail.ebshome.net>
Date: Tue, 15 Jul 2003 09:27:10 -0700
To: Matt Porter <mporter@kernel.crashing.org>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: [RFC] consistent_sync and non L1 cache line aligned buffers
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030715091731.C6208@home.com>
References: <5.1.0.14.2.20030714210220.0308a070@mail.zultys.com>
 <5.1.0.14.2.20030714210220.0308a070@mail.zultys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 09:17 AM 7/15/2003, Matt Porter wrote:
>I'll agree that it's a better hack, but since the offending areas in
>the SCSI subsystem are easily located, it seems wiser to fix upstream.

Matt, the problem is it wasn't that *easy* to locate this, at least for me :)
I'm not sure that this is the only place..

>We still need someone with interest AND time to properly fix the
>consistent alloc from irq issue. :)  All of the patches post to date
>are incomplete bandaids.

Uhh, I switched to solution which uses pre allocated consistent memory (10
pages are enough for sym53c8xx_2).
It's still not a generic solution, but at least it's safe :)

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
