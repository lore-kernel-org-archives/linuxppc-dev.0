Message-ID: <20040206192023.13791.qmail@kunk.qbjnet.com>
Subject: alsa dmasound in bk 2.6.2
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 6 Feb 2004 13:20:23 -0600 (CST)
From: Bob Brose <bob@kunk.qbjnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm sure I'm missing something but can someone give me a clue as to what
to do with this:

With a 2.6.2 bk kernel I compile dmasound under the mac alsa drivers
as a module. When depmod comes along, I get:

f [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.2; fi
WARNING: /lib/modules/2.6.2/kernel/sound/ppc/snd-powermac.ko needs unknown symbol i2c_smbus_write_block_data
WARNING: /lib/modules/2.6.2/kernel/sound/ppc/snd-powermac.ko needs unknown symbol i2c_add_driver
WARNING: /lib/modules/2.6.2/kernel/sound/ppc/snd-powermac.ko needs unknown symbol i2c_smbus_write_byte_data
WARNING: /lib/modules/2.6.2/kernel/sound/ppc/snd-powermac.ko needs unknown symbol i2c_del_driver
WARNING: /lib/modules/2.6.2/kernel/sound/ppc/snd-powermac.ko needs unknown symbol i2c_detach_client
WARNING: /lib/modules/2.6.2/kernel/sound/ppc/snd-powermac.ko needs unknown symbol i2c_attach_client

So, I assume that dmasound needs I2C but I can't get I2C to configure
into the kernel. I tried make mrproper as well.

The result:
# using defaults found in arch/ppc/defconfig
#
arch/ppc/defconfig:708: trying to assign nonexistent symbol MOUSE_PS2_SYNAPTICS
arch/ppc/defconfig:762: trying to assign nonexistent symbol I2C_CHARDEV

and so on for every I2C symbol.

This is debian testing on a 6360 with gcc 3.3.2

Any hints appreciated!

Bob
--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
