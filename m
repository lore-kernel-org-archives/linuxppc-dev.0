Date: Wed, 17 Nov 1999 12:04:16 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: BenH <bh40@calva.net>
cc: Michael Schmitz <schmitz@simul.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.27 on CHRP Longtrail
In-Reply-To: <19991112220020.007302@smtp.calvacom.fr>
Message-ID: <Pine.LNX.4.10.9911171137430.14700-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Fri, Nov 12, 1999, Michael Schmitz
> <schmitz@simul.biophys.uni-duesseldorf.de> wrote:
> 
> >Please do. I tried to use xmon_printf for this very purpose on my Lombard
> >with 2.3.13 with no success. 
> 
> You can do this currently if you have a recent version of xmon (I don't
> remember when Paul actually changed xmon to use the early boot text).
> Boot with BootX (with no video driver). Make sure the init code in
> arch/ppc/xmon/start.c will map the fb and use prom_print().

I think prom_print was actually what I tried to use but it wasn't
producing any output. I'll try xmon_printf as soon as I find time to play
with 2.3 kernels again. (I'm currently beating on mon to make it play with 
the PMU on Powerbooks ...)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
