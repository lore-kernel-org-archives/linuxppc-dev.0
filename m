Date: Fri, 21 May 2004 23:45:21 -0700
From: Jamie Heilman <jamie@audible.transient.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: BriQ & Linux 2.6
Message-ID: <20040522064520.GM8520@audible.transient.net>
References: <20040521074018.GD8520@audible.transient.net> <1085181034.6755.7.camel@gaston> <20040521233523.GJ8520@audible.transient.net> <1085199239.9230.4.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1085199239.9230.4.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> Well... the base clock isn't what the driver thinks, so it must be
> hacked. But the driver doesn't provide a clean way to set another
> base clock, I'm trying to find something better than what the hack
> in the patch does.

Well progress so far, I have 2.6.6 booting now, had to fumble a little
to apply one chunk but the rest was easy.  Problems so far: during the
entire boot, my console is line-noise-like hash[1], until runlevel 2,
then it starts behaving correctly.  The NICs (I have the PCI
expansion + extra NIC board) are having some issues....

          RX packets:118521 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:57244 dropped:0 overruns:0 carrier:57244

...and yet, strangly I don't seem to be having any obvious network
performance problems.

Now this isn't the first time I've had issues with either of those,
and I think there are some patches in the Total Impact kernel source
for the NIC issue.  So I'm definately a lot closer than I was.

--
Jamie Heilman                     http://audible.transient.net/~jamie/
"...thats the metaphorical equivalent of flopping your wedding tackle
 into a lion's mouth and flicking his lovespuds with a wet towel, pure
 insanity..."                                           -Rimmer

[1] like all: x<��x�x��x��x��x�x��x<�x�x
    but then all the kernels from Total Impact do the same thing, and
    I bet if I remove the base clock hack it will just work.  Or
    atleast appear to just work.  Sometimes I wonder if my BriQ is
    cursed.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
