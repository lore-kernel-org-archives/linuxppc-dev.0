From: benh@kernel.crashing.org
To: <msokolov@ivan.Harhan.ORG>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
Date: Thu, 11 Apr 2002 17:13:02 +0100
Message-Id: <20020411161302.6159@mailhost.mipsys.com>
In-Reply-To: <0204111540.AA28629@ivan.Harhan.ORG>
References: <0204111540.AA28629@ivan.Harhan.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I guess I'll just have to convince Debian to make a package from
>linuxppc_2_4_alt to support HEC PPCStar machines and show all these exchanges
>as evidence that the PPC MAINTAINERS are not intent on allowing new machine
>support into 2.4 any time soon.

Don't get to conclusions so fast. We have already a whole bunch of new
machines support pending in _devel that has to be merged, and that will
happen after 2.4.19. Things aren't fast on a stable kernel, but that's
the way it should be.

>> Well.. you forget pmac here ;)
>>
>> The problem is that pmac has it's own serial HW with a different driver,
>> but still may need serial.o for PCI serial cards or pcmcia modems.
>
>But then a PMac doesn't need anything in rs_table!

But a pmac/prep/chrp kernel may.

>If in addition to PMacs a CONFIG_GENERIC_PPC32 kernel supports other machines
>with serial consoles, the serial driver must be compiled in. If no machines
>other than PMac are selected, you can compile without the serial driver in
>there as the PMac port won't care about rs_table and won't call
>early_serial_setup. Then if you load it as a module, you'll have no fixed
>ports
>will get all PCI, PCMCIA, etc. ones, which is exactly what you need here.
>
>So I don't see a problem.

Not having it as a module may prevent pcmcia modems from working.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
