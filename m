Message-ID: <39AAF258.B43B901@mvista.com>
Date: Mon, 28 Aug 2000 16:14:32 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Alex Shnitman <alexsh@hectic.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
References: <20000828225504.B23679@hectic.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex Shnitman wrote:

> Hi,
>
> I've seen that Hard Hat Linux supports the Sandpoint board with
> MPC8240 and MPC755. We have a 7400 processor there though. Does anyone
> have any experience with this configuration? Can Linux run on it?
>
> Also, is there anything special I should know about booting Linux from
> dink32? Here's what I did, and how it failed. I got the latest kernel
> snapshot from fsmlabs (I tried the same with both the latest 2.2 and
> 2.3 trees).

Alex,

If you want to use Hard Hat Linux on the Sandpoint, you need to get it from
Monta Vista's CDK 1.2.  The LSP (Linux Support Package) you're looking for is
sp8240 (for Sanpoint 8240--also works with a 755/107 combo).  You can find it
online at ftp://ftp.mvista.com/pub/CDK/1.2/cd/PowerPC/ppc_82xx/RPMS/

You will probably need most of the rpms and so it will take a while (its based
on 2.4.0-test2).

The code in that LSP has not trickled up to fsmlabs so I'm not surprised what
you downloaded from there didn't work.

Nothing special for DINK except that you need to let it run until it puts its
prompt out (the kernel expects DINK to do some early initialization).

I haven't tested with a 7400 but it should be fairly close if it doesn't work
right out of the box.  That is, work without altivec.  I don't know what's
involved to use the altivec support in Linux.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
