Date: Fri, 3 Nov 2000 22:53:11 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: cl.en@gmx.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
In-Reply-To: <19340928092653.6730@192.168.1.2>
Message-ID: <Pine.LNX.4.10.10011032251480.26175-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Seems I've seen that message before ???

> >Sep 18 00:35:03 apple kernel: Kernel panic: kernel access of bad area pc
> >c00cf34c lr c00cfa88 address 24 tsk
> >+pmud/297
> >
> >System.map-2.2.18pre4-ben1:
> >c00cf218 t idepmac_sleep_device
> >c00cf334 t idepmac_wake_device
>
> Please, try to disassemble idepmac_sleep_device with objdump and see
> where exactly it crashes. Looks like there may be some bad pointer going
> on there...

Rather disassemble idepmac_wake_device (that's where tha PC falls IMHO).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
