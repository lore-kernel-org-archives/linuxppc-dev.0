Date: Mon, 20 May 2002 13:31:49 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Dan Kegel <dkegel@ixiacom.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: When did ppc405 support stabilize?
Message-ID: <20020520133149.A17318@ecam.san.rr.com>
References: <3CE94AE9.E18D2B1E@ixiacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CE94AE9.E18D2B1E@ixiacom.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 20, 2002 at 12:13:45PM -0700, Dan Kegel wrote:
>
> (resending after subscribing...)
>
> Hi,
> I'm trying to track down a khttpd problem.
> khttpd was solid in Hard Hat Linux 2.0 on ppc405,
> it's stable on the x86 (at least after my recent patch),
> and it's (mostly) stable on the imac running plain old 2.4.18.
> However, it seems to have serious problems on ppc405
> with 2.4.17 and on from linuxppc_2_4_devel.
>
> I'd like to try older linuxppc_2_4_devel kernels
> until I find where the problem started.
> I guess I'll have to work my way backwards, since I don't know
> when ppc405 support stabilized in that tree.
>
> How far back should I expect to be able to go?
>
> BTW, here's the cheesy script I'm using to fetch old kernel versions;
> I'm relying on the v2.4.xx tags.

look into 'bk export' instead of the script.

I believe the tags are off the base Linux kernel and they have never
worked for the 405gp.

The recent trees have been working for me but there have been a lot
of changes to try to get a common OCP framework.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
