Message-Id: <5.1.0.14.2.20030224135756.0465b778@mail.ebshome.net>
Date: Mon, 24 Feb 2003 14:29:18 -0800
To: <brian.auld@adic.com>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: RE: Kernel Preemption patch
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <995FF289C9D69747A09E42992644595405B23686@penguin.adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 12:45 PM 2/24/2003, brian.auld@adic.com wrote:
>In a previous post, you mentioned that you had the Kernel Preemption patch
>as well as the Real-Time scheduler patch running on a 2.4.19 kernel on
>405/440 platforms...
>
>If not, how did you manage to propogate forward George Anzinger's latest
>patch (2.4.16) to your kernel?

I used George Anzinger patch (it looked less intrusive than 0(1) to me)
with small fixes.

Actually I applied 3 different patches to achieve reasonable user-mode soft
real-time for 440GP kernel:

1) preempt patch (from MVL)
2) rtsched by George Anzinger
3) lock-break by RML

I can make a patch for 2.4.19 PPC devel tree snapshot with all those
patches and my fixes if you want.

I'm not sure whether I should post it to the list or not.

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
