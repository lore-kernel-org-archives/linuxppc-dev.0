From: Benjamin Herrenschmidt <bh40@calva.net>
To: <cl.en@gmx.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
Date: Fri, 3 Nov 2000 16:55:09 +0100
Message-Id: <19340928092653.6730@192.168.1.2>
In-Reply-To: <20001103162250.A367@olis.north.de>
References: <20001103162250.A367@olis.north.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>just for the record:
>
>I've got the same crash as Albrecht in Sept. with 2.2.18pre4-ben1
>and linuxppc2k on my PB3400 without the wakebay app.
>
>Sep 18 00:35:03 apple kernel: Kernel panic: kernel access of bad area pc
>c00cf34c lr c00cfa88 address 24 tsk
>+pmud/297
>
>System.map-2.2.18pre4-ben1:
>c00cf218 t idepmac_sleep_device
>c00cf334 t idepmac_wake_device
>c00cf400 t idepmac_sleep_interface
>c00cf4e4 t idepmac_wake_interface
>c00cf728 t idepmac_notify_sleep
>c00cfab0 T ide_dma_intr
>c00cfb8c T ide_build_dmatable

Please, try to disassemble idepmac_sleep_device with objdump and see
where exactly it crashes. Looks like there may be some bad pointer going
on there...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
