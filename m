Message-ID: <40D4187D.6090804@246tNt.com>
Date: Sat, 19 Jun 2004 12:42:05 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC52xx lite5200 support for booting from dBUG
References: <20040603090635.B7347@home.com> <20040603164245.B24A9C109F@atlas.denx.de> <20040603113302.A24468@home.com> <20040603185053.GN15195@smtp.west.cox.net> <40BF87BB.4020808@246tNt.com> <20040603134804.B24468@home.com> <40C8BB6C.4040709@246tNt.com> <20040618192046.GA22607@zenos.farnsworth.org> <20040618200414.GA25461@zenos.farnsworth.org>
In-Reply-To: <20040618200414.GA25461@zenos.farnsworth.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks,

I think a file ( arch/ppc/boot/simple/mpc52xx_tty.c ) is missing from
the patch.


    Sylvain Munaut


Dale Farnsworth wrote:

 > This patch allows Sylvain's 2.6 support for the lite5200 to boot
 > from dBUG as well as U-Boot.
 >
 > When the arch/ppc/boot/simple bootwrapper is used, it computes the
 > values that U-boot would have supplied and stores them in __res.
 > That works for all needed fields except __res.bi_baudrate, which
 > can't be determined from the environment.  So, I added
 > CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD to supply the default baud rate.
 >  The value of CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD is ignored if the
 > bootloader (U-boot) supplies the baudrate.
 >
 > -Dale Farnsworth


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
