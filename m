Date: Fri, 30 Mar 2001 03:08:18 +0200
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Stability of MontaVista's 2.4.0-test2-1.2.2-1
Message-ID: <20010330030817.D1061@alexsh.dyn.dhs.org>
References: <H00002af04b2e173@MHS> <3AC23B01.A9162C3B@matrox.com> <3AC25348.C33F8692@mvista.com> <20010329163258.C13092@mangodsp.com> <3AC37111.C041F0CA@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3AC37111.C041F0CA@mvista.com>; from mgreer@mvista.com on Thu, Mar 29, 2001 at 10:29:53AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Mark!

On Thu, Mar 29, 2001 at 10:29:53AM -0700, you wrote the following:

> Evidently, some [pmac-related] changes have gone in the last 2-3
> weeks that have broken things.  I'll take a look at it today or
> tomorrow.
>
> If you can't wait, its probably not hard to fix.  Its likely nothing
> more than adding some stubs to ppc_stubs.c

At least one function (I don't remember which -- I'm not at work now
so I can't check) was declared static, while being called from other
files. These must be quite simple errors to fix. I haven't looked at
the other functions yet.


--
Alex Shnitman <alexsh@hectic.net>
http://alexsh.hectic.net/   UIN 188956
PGP 0xEC5D619D / E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
