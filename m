Date: Sat, 7 Feb 2004 09:45:30 +0100 (CET)
From: Christiaan Welvaart <cjw@daneel.dyndns.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: alsa dmasound in bk 2.6.2
In-Reply-To: <20040206192023.13791.qmail@kunk.qbjnet.com>
Message-ID: <Pine.LNX.4.58.0402070937400.13765@zem.cjw.nep>
References: <20040206192023.13791.qmail@kunk.qbjnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 6 Feb 2004, Bob Brose wrote:

> With a 2.6.2 bk kernel I compile dmasound under the mac alsa drivers
> as a module. When depmod comes along, I get:
>
> f [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.2; fi
> WARNING: /lib/modules/2.6.2/kernel/sound/ppc/snd-powermac.ko needs unknown symbol i2c_smbus_write_block_data
> WARNING: /lib/modules/2.6.2/kernel/sound/ppc/snd-powermac.ko needs unknown symbol i2c_add_driver
> WARNING: /lib/modules/2.6.2/kernel/sound/ppc/snd-powermac.ko needs unknown symbol i2c_smbus_write_byte_data
> WARNING: /lib/modules/2.6.2/kernel/sound/ppc/snd-powermac.ko needs unknown symbol i2c_del_driver
> WARNING: /lib/modules/2.6.2/kernel/sound/ppc/snd-powermac.ko needs unknown symbol i2c_detach_client
> WARNING: /lib/modules/2.6.2/kernel/sound/ppc/snd-powermac.ko needs unknown symbol i2c_attach_client
>
> So, I assume that dmasound needs I2C but I can't get I2C to configure
> into the kernel. I tried make mrproper as well.
>
> The result:
> # using defaults found in arch/ppc/defconfig
> #
> arch/ppc/defconfig:708: trying to assign nonexistent symbol MOUSE_PS2_SYNAPTICS
> arch/ppc/defconfig:762: trying to assign nonexistent symbol I2C_CHARDEV
>
> and so on for every I2C symbol.

http://marc.theaimsgroup.com/?l=linux-kernel&m=107607571627355&w=2

I "fixed" it by applying the 2.6.2-mm1 patch, but still need to find time
for a reboot so can't say if that was a good idea.


    Christiaan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
