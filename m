Message-ID: <39453A10.55C5F4D6@embeddededge.com>
Date: Mon, 12 Jun 2000 15:29:20 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Cort Dougan <cort@fsmlabs.com>
CC: rodgersg@us.ibm.com, linuxppc-dev@lists.linuxppc.org, bh40@calva.net,
        paulus@linuxcare.com, geert@linux-m68k.org, paubert@iram.es,
        dburcaw@terraplex.com, hollis@linuxppc.com, drdoc@netcene.com,
        gdt@linuxppc.org, dan_bethe@yahoo.com, khendricks@ivey.uwo.ca,
        tgall@us.ibm.com, trini@kernel.crashing.org, jcarr@linuxppc.com,
        jhaas@linuxppc.com, devel@yellowdoglinux.com, tomcook@us.ibm.com
Subject: Re: PowerPC BOF at Ottawa Linux Symposium July 19
References: <OF1ED8D32F.3AA2FD26-ON852568F9.0061D9AD@pok.ibm.com> <20000610182014.H31097@medea.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort Dougan wrote:
>
> I won't be in Ottawa but I have a suggestion for something to talk about
> there if anyone would be interested in it.  Could you have a brainstorming
> session about how to re-structure the chip/architecture portions of
> arch/ppc/?

I don't know if I will be there, but I would like to make a comment
on this as well.  The BOF started as a workstation/server discussion,
and the chip/architecture issues are really the result of the variety
of embedded PowerPC processors and boards.

There is PREP/CHRP/PowerMac that you have successfully combined, with
minor configuration differences among all of them.  Then we have lots
of different PowerPC cores with highly integrated functional units on
a variety of different board configurations.  I think we are fortunate
to be able to provide this wide range of solutions, but it does present
the source code structure challenge as Cort (and others) have discussed.

As a workstation/server BOF, I don't know how much interest exists to
discuss this.  The easy answer is a set of orthogonal directory trees,
but I think the highest priority should be on maintaining a set of
common files.  Having experienced splitting some processor dependent
files, I would still take the #ifdefs over tracking similar changes
across multiple files.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
