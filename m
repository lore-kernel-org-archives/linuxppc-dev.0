Return-Path: <k_shivanii@yahoo.com>
Received: from web32111.mail.mud.yahoo.com (web32111.mail.mud.yahoo.com
	[68.142.207.125]) by ozlabs.org (Postfix) with SMTP id B66D8679E9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Feb 2006 14:19:10 +1100 (EST)
Message-ID: <20060221031228.63233.qmail@web32111.mail.mud.yahoo.com>
Date: Mon, 20 Feb 2006 19:12:28 -0800 (PST)
From: shivani kirubanandan <k_shivanii@yahoo.com>
Subject: hello error during kernel compilation of ml300 powerpc405 plzz help
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hello ,
i encountered this error while tryin to compile a
ml300 xilinx specific powerpc405 kernel...plz help me
out!


make[1]: Leaving directory
`/home/shivani/downloads/linux-2.4.26/arch/ppc/4xx_io'
/opt/crosstool/gcc-3.3.2-glibc-2.3.2/powerpc-405-linux-gnu/bin/powerpc-405-linux-gnu-ld
-T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head_4xx.o init/main.o init/version.o
init/do_mounts.o \
        --start-group \
        arch/ppc/kernel/kernel.o
arch/ppc/platforms/platform.o arch/ppc/mm/mm.o
arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o
ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/pci/driver.o
drivers/net/wireless/wireless_net.o
drivers/macintosh/macintosh.o drivers/video/video.o
drivers/usb/usbdrv.o drivers/media/media.o
drivers/input/inputdrv.o arch/ppc/4xx_io/4xx_io.o \
        net/network.o \
        /home/shivani/downloads/linux-2.4.26/lib/lib.a
\
        --end-group \
        -o vmlinux
drivers/char/char.o(.text+0x1d824): In function
`handle_kbd_event':
: undefined reference to `x8042_read_status'
drivers/char/char.o(.text+0x1d844): In function
`handle_kbd_event':
: undefined reference to `x8042_read_input'
drivers/char/char.o(.text+0x1d860): In function
`handle_kbd_event':
: undefined reference to `x8042_read_status'
drivers/char/char.o(.text+0x1dc64): In function
`kbd_write_command_w':
: undefined reference to `x8042_write_command'
drivers/char/char.o(.text+0x1dcb0): In function
`kbd_write_output_w':
: undefined reference to `x8042_write_output'
drivers/char/char.o(.text+0x1dd68): In function
`panic_blink':
: undefined reference to `x8042_read_status'
drivers/char/char.o(.text+0x1dd8c): In function
`panic_blink':
: undefined reference to `x8042_write_output'
drivers/char/char.o(.text+0x1ddb0): In function
`panic_blink':
: undefined reference to `x8042_read_status'
drivers/char/char.o(.text+0x1ddec): In function
`panic_blink':
: undefined reference to `x8042_write_output'
drivers/char/char.o(.text.init+0x1604): In function
`kbd_read_data':
: undefined reference to `x8042_read_status'
drivers/char/char.o(.text.init+0x162c): In function
`kbd_read_data':
: undefined reference to `x8042_read_input'
make: *** [vmlinux] Error 1



cheers
shivani


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
