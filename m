In-Reply-To: <19990112162631.B29622@dirkpitt.solsoft.fr>
Date: Tue, 12 Jan 1999 20:29:48 +0100
To: linuxppc-dev@lists.linuxppc.org,
        Hubert Figuiere <Hubert.Figuiere@solsoft.fr>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Porting to NuBus PowerMacs
Message-Id: <19990112202948.028828@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 12, 1999, Hubert Figuiere <Hubert.Figuiere@solsoft.fr> wrote:

>I'd like to know what would be the complexity of porting LinuxPPC
>to NuBus PowerMacs ?

<asun@saul6.u.washington.edu> is already thinking about it.

>Here are my thoughts:
>
>-we have BootX. So we can BootX LinuxPPC. We just need to build a
> fake OpenFirmware device tree for BootX so he can pass it the
> kernel

That was the original idea, but several things makes me wonder if it
wouldn't be simpler to just pass a list of known infos (total ram size,
processor type, machine ID and a couple of baseaddresses) to the kernel
and almost-hard-code things in drivers since this hardware will not
evolve very much now ;-)

Basically, I have to provide him a version of BootX that works on those
machines and provide the requested infos. I didn't have time to work a
lot on BootX those few last days, but I think I'll send him something
around the end of the week, maybe next week.

>-we have the source of the Mach MicroKernel, hence we have enough
> to rewrite the specification to rewrite drivers for LinuxPPC.
> Some components and drivers may directly come from Linux Mac68k.

We have also a lot of potentially useful things in the mac68k and APUS ports.

>Note that I don't have a NuBus PowerMac. Only a 6200 (and my
>PowerCenter Pro, already supported).

;-)

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
