Date: Wed, 30 Aug 2000 21:58:56 +0300
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
Message-ID: <20000830215856.B5340@hectic.net>
References: <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net> <39AC2AB9.D47ADE73@mvista.com> <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net> <39AC0BF9.38DB6A9A@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39AC0BF9.38DB6A9A@mvista.com>; from mgreer@mvista.com on Tue, Aug 29, 2000 at 12:16:09PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Mark!

On Tue, Aug 29, 2000 at 12:16:09PM -0700, you wrote the following:

> > I downloaded the kernel and tried it. It starts booting, but it hangs
> > right after initializing the the OpenPIC. :-( I'll download the source
> > code tonight and try to look at it, although I don't have much hopes
> > gotta learn though.
> >
> > Is there any book that you recommend to get me started? Any other
> > docs/tips?
>
> Oops, I should have included the sandpoint switch settings.  For
> this version of the kernel, the sandpoint switches must be set as
> follows:
>
> S4,S3: up, down
> S5: down
> S6: down (yours is probably up which is why it hung in openpic)
>
> Try this and see if it helps.

It did! The kernel boots fine now all the way through.

Thanks a lot!

Another question: what would be the best way to go about booting Linux
from the flash? Would flashing the kernel in instead of the dink32
monitor do the trick, or does dink32 do some important initializations
that are needed for the kernel to boot?


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

> *Real* programmers use
>     cat > a.out
No way, /real/ programmers use
    zcat > a.out
'cause you can type faster that way.
	-- from a Slashdot discussion

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
