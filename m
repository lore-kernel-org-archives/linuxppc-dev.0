Reply-To: <manu@stapf.org>
From: "Emmanuel STAPF" <manu@stapf.org>
To: "'Brad Boyer'" <flar@pants.nu>
Cc: "'Kaoru Fukui'" <k_fukui@highway.ne.jp>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: RE: Error when linking
Date: Sat, 20 Oct 2001 14:28:49 -0700
Message-ID: <000401c159ae$35376950$650a000a@venice>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20011020184710.1715A2B54A@marcus.pants.nu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Indeed my problem is supposed to be around 50MB in size and as you
guessed I can't make it smaller.

I looked at the mailing list archive but I could not find what I should
use to make `ld' link my object files. So if anyone as the solution do
not hesitate to share it.

Thanks,
Manu

> -----Original Message-----
> From: Brad Boyer [mailto:flar@pants.nu]
> Sent: Saturday, October 20, 2001 11:47 AM
> To: manu@stapf.org
> Cc: 'Kaoru Fukui'; linuxppc-dev@lists.linuxppc.org
> Subject: Re: Error when linking
>
>
>
> I suspect the problem is that you're trying to call functions that the
> linker is putting farther apart than can be referenced in a 24 bit
> offset, which is the largest branch offset allowed with that type
> of call. Would your final program be bigger than 16M? Any branch with
> an offset more than 16M can't fit in a normal ppc branch instruction.
> If possible, you should make your program smaller, but if that isn't
> feasible, I seem to remember someone mentioning a way to make the
> linker do calls with absolute, 32 bit addresses. I just don't remember
> how to do it, and the ld manpages aren't the best in the world for
> architecture specific stuff. This came up once before on the mailing
> list, so you might try to search the archives.
>
> 	Brad Boyer
> 	flar@allandria.com
>
> Emmanuel STAPF wrote:
> >
> >
> > I should add that they occur only when I have my 1000
> files. A similar
> > project using those C function but smaller compiles without
> any problem.
> >
> > Any idea why and what are the possible solutions?
> > Manu
> >
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
