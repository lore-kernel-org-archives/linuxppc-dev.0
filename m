Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 34288B7D1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Apr 2010 10:08:13 +1100 (EST)
Date: Fri, 2 Apr 2010 01:08:09 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: ST <st@iss.tu-darmstadt.de>
Subject: Re: dts,i2c,pcf8574 on Xilinx XUP
Message-ID: <20100401230809.GB13989@pengutronix.de>
References: <201004012250.33877.st@iss.tu-darmstadt.de>
	<20100401221427.GA13989@pengutronix.de>
	<201004020042.08010.st@iss.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
In-Reply-To: <201004020042.08010.st@iss.tu-darmstadt.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 02, 2010 at 12:42:07AM +0200, ST wrote:

(BTW your full name in the mail header would be appreciated)

> Hi Wolfram
>=20
> Thanks for your reply.
> > Is there any output before the crash? Also, the complete device tree and
> > bootlog may be useful.
> Ups, forgot to attach.
>=20
> The bootlog is below. There is no output or error msg of the kernel.
> Its just gone: no network no nothing. There is a jtag interface but=20
> i haven't figured out how to use that.
>=20
> There is only one pcf8574 connected to the i2c bus and nothing else, so
> i think that dumping the i2c bus should do no harm?
>=20
> Best regards
> ST
> =20
> zImage starting: loaded at 0x00400000 (sp: 0x004f9fb0)                   =
                     =20
> Allocating 0x220e61 bytes for kernel ...                                 =
                     =20
> gunzipping (0x00000000 <- 0x0040d000:0x004f8ac0)...done 0x20399c bytes   =
                     =20
>=20
> Linux/PowerPC load: console=3DttyUL0 root=3D/dev/xsa2 init=3D/usr/sbin/in=
it
> Finalizing device tree... flat tree at 0x506300                     =20
> [    0.000000] Using Xilinx Virtex machine description              =20
> [    0.000000] Linux version 2.6.32 (tstone@ligeia) (gcc version 4.3.2=20
> (OSELAS.Toolchain-trunk) ) #2 Thu Apr 1 23:19:08 CEST 2010               =
                                                                           =
          =20
> [    0.000000] Zone PFN ranges:                                          =
                                         =20
> [    0.000000]   DMA      0x00000000 -> 0x00010000                       =
                                         =20
> [    0.000000]   Normal   0x00010000 -> 0x00010000                       =
                                         =20
> [    0.000000] Movable zone start PFN for each node                      =
                                         =20
> [    0.000000] early_node_map[1] active PFN ranges                       =
                                         =20
> [    0.000000]     0: 0x00000000 -> 0x00010000                           =
                                         =20
> [    0.000000] MMU: Allocated 1088 bytes of context maps for 255 contexts=
                                         =20
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  To=
tal=20
> pages: 65024                         =20
> [    0.000000] Kernel command line: console=3DttyUL0 root=3D/dev/xsa2=20
> init=3D/usr/sbin/init                             =20
> [    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)       =
                                         =20
> [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 b=
ytes)                                    =20
> [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 byt=
es)                                      =20
> [    0.000000] Memory: 257408k/262144k available (1928k kernel code, 4452=
k=20
> reserved, 136k data, 115k bss, 104k init)                                =
                                                                           =
      =20
> [    0.000000] Kernel virtual memory layout:                             =
                                         =20
> [    0.000000]   * 0xffffe000..0xfffff000  : fixmap                      =
                                         =20
> [    0.000000]   * 0xfde00000..0xfe000000  : consistent mem              =
                                         =20
> [    0.000000]   * 0xfde00000..0xfde00000  : early ioremap               =
                                         =20
> [    0.000000]   * 0xd1000000..0xfde00000  : vmalloc & ioremap           =
                                         =20
> [    0.000000] Hierarchical RCU implementation.                          =
                                         =20
> [    0.000000] NR_IRQS:512                                               =
                                         =20
> [    0.000000] clocksource: timebase mult[1400000] shift[22] registered  =
                                         =20
> [    0.000000] Console: colour dummy device 80x25                        =
                                         =20
> [2797861247.029784] Mount-cache hash table entries: 512                  =
                                         =20
> [2797861247.038137] NET: Registered protocol family 16                   =
                                         =20
> [2797861247.097587] bio: create slab <bio-0> at 0                        =
                                         =20
> [2797861247.103850] XGpio: /plb@0/gpio@81460000: registered              =
                                         =20
> [2797861247.105898] XGpio: /plb@0/gpio@81440000: registered              =
                                         =20
> [2797861247.107782] XGpio: /plb@0/gpio@81420000: registered              =
                                         =20
> [2797861247.109683] XGpio: /plb@0/gpio@81400000: registered              =
                                         =20
> [2797861247.121074] Switching to clocksource timebase                    =
                                         =20
> [2797861247.123476] Switched to NOHz mode on CPU #0                      =
                                         =20
> [2797861247.138696] NET: Registered protocol family 2                    =
                                         =20
> [2797861247.139221] IP route cache hash table entries: 2048 (order: 1, 81=
92=20
> bytes)                                =20
> [2797861247.140429] TCP established hash table entries: 8192 (order: 4, 6=
5536=20
> bytes)                              =20
> [2797861247.142396] TCP bind hash table entries: 8192 (order: 3, 32768 by=
tes)                                     =20
> [2797861247.143266] TCP: Hash tables configured (established 8192 bind 81=
92)                                      =20
> [2797861247.143332] TCP reno registered                                  =
                                         =20
> [2797861247.144436] NET: Registered protocol family 1                    =
                                         =20
> [2797861247.183657] msgmni has been set to 503                           =
                                         =20
> [2797861247.184102] io scheduler noop registered (default)               =
                                         =20
> [2797861247.184174] io scheduler anticipatory registered                 =
                                         =20
> [2797861247.343035] 84000000.serial: ttyUL0 at MMIO 0x84000003 (irq =3D 1=
6) is a=20
> uartlite                           =20
> [2797861247.584681] console [ttyUL0] enabled                             =
                                         =20
> [2797861247.695229] brd: module loaded
> [2797861247.701082] xsysace 83600000.sysace: Xilinx SystemACE revision 1.=
0.12
> [2797861247.707889] xsysace 83600000.sysace: capacity: 15858864 sectors
> [2797861247.714109]  xsa: xsa1 xsa2
> [2797861247.733755] Xilinx SystemACE device driver, major=3D254
> [2797861247.741455] xilinx-xps-spi 81818000.xps-spi: at 0x81818000 mapped=
 to=20
> 0xD101A000, irq=3D18
> [2797861247.761947] xilinx_emaclite 81000000.ethernet: Device Tree Probing
> [2797861247.768077] xilinx_emaclite 81000000.ethernet: MAC address is now=
  2:=20
> 0: 0: 0: 0: 0
> [2797861247.778109] xilinx_emaclite 81000000.ethernet: Xilinx EmacLite at=
=20
> 0x81000000 mapped to 0xD10A0000, irq=3D19
> [2797861247.801825] mice: PS/2 mouse device common for all mice
> [2797861247.810511] i2c /dev entries driver
> [2797861247.817952] Device Tree Probing 'i2c'
> [2797861247.830658]  #0 at 0x81600000 mapped to 0xD10C0000, irq=3D20
> [2797861247.838743] pcf857x: probe of 0-0020 failed with error -22

Doesn't look good here. Do you have the latest version of the driver?
(CCing i2c)

> [2797861247.845166] TCP cubic registered
> [2797861247.847830] NET: Registered protocol family 17
> [2797861247.860624] drivers/rtc/hctosys.c: unable to open rtc device (rtc=
0)
> [2797861247.882998] VFS: Mounted root (ext2 filesystem) readonly on devic=
e=20
> 254:2.
> [2797861247.889377] Freeing unused kernel memory: 104k init
> cat: /proc/cmdline: No such file or directory
> [2797861250.818870] EXT2-fs warning: mounting unchecked fs, running e2fsc=
k is=20
> recommended
> mounting filesystems...done.
> running rc.d services...
> starting udev
> mounting tmpfs at /dev
> creating static nodes
> starting udevd...done
> waiting for devices...done
> syslogd starting
> Starting system message bus: dbus.
> starting sshd...done
> starting network interfaces...
> lighttpd: starting
> lighttpd: done
> /bin/sh: exec: line 1: /etc/init.d/rc: not found
>=20
> xup login: root
> root@xup:~ i2cd
> i2cdetect  i2cdump
> root@xup:~ i2cd
> i2cdetect  i2cdump
> root@xup:~ i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
> 10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
> 20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
> 30:

> /*
>  * Device Tree Generator version: 1.2
>  *
>  * (C) Copyright 2007-2008 Xilinx, Inc.
>  * (C) Copyright 2007-2008 Michal Simek
>  *
>  * Michal SIMEK <monstr@monstr.eu>
>  *
>  * This program is free software; you can redistribute it and/or
>  * modify it under the terms of the GNU General Public License as
>  * published by the Free Software Foundation; either version 2 of
>  * the License, or (at your option) any later version.
>  *
>  * This program is distributed in the hope that it will be useful,
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>  * GNU General Public License for more details.
>  *
>  * You should have received a copy of the GNU General Public License
>  * along with this program; if not, write to the Free Software
>  * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
>  * MA 02111-1307 USA
>  *
>  * CAUTION: This file is automatically generated by libgen.
>  * Version: Xilinx EDK 10.1.03 EDK_K_SP3.6
>  *
>  * XPS project directory: xps_linux
>  */
>=20
> /dts-v1/;
> / {
> 	#address-cells =3D <1>;
> 	#size-cells =3D <1>;
> 	compatible =3D "xlnx,virtex405", "xlnx,virtex";
> 	model =3D "testing";
> 	DDR_SDRAM: memory@0 {
> 		device_type =3D "memory";
> 		reg =3D < 0x0 0x10000000 >;
> 	} ;
> 	alias {
> 		ethernet0 =3D &Ethernet_MAC;
> 		serial0 =3D &RS232_Uart_1;
> 	} ;
> 	chosen {
> 		bootargs =3D "console=3DttyUL0 root=3D/dev/xsa2 init=3D/usr/sbin/init";
> 		linux,stdout-path =3D "/plb@0/serial@84000000";
> 	} ;
> 	cpus {
> 		#address-cells =3D <1>;
> 		#cpus =3D <0x1>;
> 		#size-cells =3D <0>;
> 		ppc405_0: cpu@0 {
> 			clock-frequency =3D <200000000>;
> 			compatible =3D "PowerPC,405", "ibm,ppc405";
> 			d-cache-line-size =3D <0x20>;
> 			d-cache-size =3D <0x4000>;
> 			dcr-access-method =3D "native";
> 			dcr-controller ;
> 			device_type =3D "cpu";
> 			i-cache-line-size =3D <0x20>;
> 			i-cache-size =3D <0x4000>;
> 			model =3D "PowerPC,405";
> 			reg =3D <0>;
> 			timebase-frequency =3D <200000000>;
> 			xlnx,dcr-resync =3D <0x0>;
> 			xlnx,deterministic-mult =3D <0x0>;
> 			xlnx,disable-operand-forwarding =3D <0x1>;
> 			xlnx,fastest-plb-clock =3D "DPLB0";
> 			xlnx,generate-plb-timespecs =3D <0x1>;
> 			xlnx,mmu-enable =3D <0x1>;
> 		} ;
> 	} ;
> 	plb0: plb@0 {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		compatible =3D "xlnx,plb-v46-1.03.a", "simple-bus";
> 		ranges ;
> 		DDR_SDRAM: mpmc@84800000 {
> 			#address-cells =3D <1>;
> 			#size-cells =3D <1>;
> 			compatible =3D "xlnx,mpmc-4.03.a";
> 			reg =3D < 0x84800000 0x10000 >;
> 		} ;
> 		DIPSWs_4Bit: gpio@81460000 {
> 			compatible =3D "xlnx,xps-gpio-1.00.a";
> 			reg =3D < 0x81460000 0x10000 >;
> 			xlnx,all-inputs =3D <0x1>;
> 			xlnx,all-inputs-2 =3D <0x0>;
> 			xlnx,dout-default =3D <0x0>;
> 			xlnx,dout-default-2 =3D <0x0>;
> 			xlnx,family =3D "virtex2p";
> 			xlnx,gpio-width =3D <0x4>;
> 			xlnx,interrupt-present =3D <0x0>;
> 			xlnx,is-bidir =3D <0x1>;
> 			xlnx,is-bidir-2 =3D <0x1>;
> 			xlnx,is-dual =3D <0x0>;
> 			xlnx,tri-default =3D <0xffffffff>;
> 			xlnx,tri-default-2 =3D <0xffffffff>;
> 		} ;
> 		Ethernet_MAC: ethernet@81000000 {
> 			compatible =3D "xlnx,xps-ethernetlite-2.00.b", "xlnx,xps-ethernetlite-=
1.00.a";
> 			device_type =3D "network";
> 			interrupt-parent =3D <&xps_intc_0>;
> 			interrupts =3D < 4 0 >;
> 			local-mac-address =3D [ 02 00 00 00 00 00 ];
> 			reg =3D < 0x81000000 0x10000 >;
> 			xlnx,duplex =3D <0x1>;
> 			xlnx,family =3D "virtex2p";
> 			xlnx,rx-ping-pong =3D <0x1>;
> 			xlnx,tx-ping-pong =3D <0x1>;
> 		} ;
> 		LEDs_4Bit: gpio@81440000 {
> 			compatible =3D "xlnx,xps-gpio-1.00.a";
> 			reg =3D < 0x81440000 0x10000 >;
> 			xlnx,all-inputs =3D <0x0>;
> 			xlnx,all-inputs-2 =3D <0x0>;
> 			xlnx,dout-default =3D <0x0>;
> 			xlnx,dout-default-2 =3D <0x0>;
> 			xlnx,family =3D "virtex2p";
> 			xlnx,gpio-width =3D <0x4>;
> 			xlnx,interrupt-present =3D <0x0>;
> 			xlnx,is-bidir =3D <0x0>;
> 			xlnx,is-bidir-2 =3D <0x1>;
> 			xlnx,is-dual =3D <0x0>;
> 			xlnx,tri-default =3D <0xffffffff>;
> 			xlnx,tri-default-2 =3D <0xffffffff>;
> 		} ;
> 		PushButtons_5Bit: gpio@81420000 {
> 			compatible =3D "xlnx,xps-gpio-1.00.a";
> 			reg =3D < 0x81420000 0x10000 >;
> 			xlnx,all-inputs =3D <0x1>;
> 			xlnx,all-inputs-2 =3D <0x0>;
> 			xlnx,dout-default =3D <0x0>;
> 			xlnx,dout-default-2 =3D <0x0>;
> 			xlnx,family =3D "virtex2p";
> 			xlnx,gpio-width =3D <0x5>;
> 			xlnx,interrupt-present =3D <0x0>;
> 			xlnx,is-bidir =3D <0x1>;
> 			xlnx,is-bidir-2 =3D <0x1>;
> 			xlnx,is-dual =3D <0x0>;
> 			xlnx,tri-default =3D <0xffffffff>;
> 			xlnx,tri-default-2 =3D <0xffffffff>;
> 		} ;
> 		RS232_Uart_1: serial@84000000 {
> 			clock-frequency =3D <100000000>;
> 			compatible =3D "xlnx,xps-uartlite-1.00.a";
> 			current-speed =3D <115200>;
> 			device_type =3D "serial";
> 			interrupt-parent =3D <&xps_intc_0>;
> 			interrupts =3D < 5 0 >;
> 			port-number =3D <0>;
> 			reg =3D < 0x84000000 0x10000 >;
> 			xlnx,baudrate =3D <0x1c200>;
> 			xlnx,data-bits =3D <0x8>;
> 			xlnx,family =3D "virtex2p";
> 			xlnx,odd-parity =3D <0x0>;
> 			xlnx,use-parity =3D <0x0>;
> 		} ;
> 		SysACE_CompactFlash: sysace@83600000 {
> 			compatible =3D "xlnx,xps-sysace-1.00.a";
> 			interrupt-parent =3D <&xps_intc_0>;
> 			interrupts =3D < 0 2 >;
> 			reg =3D < 0x83600000 0x10000 >;
> 			xlnx,family =3D "virtex2p";
> 			xlnx,mem-width =3D <0x10>;
> 		} ;
> 		left_lowspeed: gpio@81400000 {
> 			compatible =3D "xlnx,xps-gpio-1.00.a";
> 			reg =3D < 0x81400000 0x10000 >;
> 			xlnx,all-inputs =3D <0x0>;
> 			xlnx,all-inputs-2 =3D <0x0>;
> 			xlnx,dout-default =3D <0x0>;
> 			xlnx,dout-default-2 =3D <0x0>;
> 			xlnx,family =3D "virtex2p";
> 			xlnx,gpio-width =3D <0x20>;
> 			xlnx,interrupt-present =3D <0x0>;
> 			xlnx,is-bidir =3D <0x1>;
> 			xlnx,is-bidir-2 =3D <0x1>;
> 			xlnx,is-dual =3D <0x0>;
> 			xlnx,tri-default =3D <0xffffffff>;
> 			xlnx,tri-default-2 =3D <0xffffffff>;
> 		} ;
> 		mdm_0: debug@84400000 {
> 			compatible =3D "xlnx,mdm-1.00.d";
> 			reg =3D < 0x84400000 0x10000 >;
> 			xlnx,family =3D "virtex2p";
> 			xlnx,interconnect =3D <0x1>;
> 			xlnx,jtag-chain =3D <0x2>;
> 			xlnx,mb-dbg-ports =3D <0x0>;
> 			xlnx,uart-width =3D <0x8>;
> 			xlnx,use-uart =3D <0x1>;
> 			xlnx,write-fsl-ports =3D <0x0>;
> 		} ;
> 		xps_bram_if_cntlr_1: xps-bram-if-cntlr@ffffc000 {
> 			compatible =3D "xlnx,xps-bram-if-cntlr-1.00.a";
> 			reg =3D < 0xffffc000 0x4000 >;
> 			xlnx,family =3D "virtex2p";
> 		} ;
> 		xps_iic_0: i2c@81600000 {
> 			compatible =3D "xlnx,xps-iic-2.00.a";
> 			interrupt-parent =3D <&xps_intc_0>;
> 			interrupts =3D < 1 2 >;
> 			reg =3D < 0x81600000 0x10000 >;
> 			xlnx,clk-freq =3D <0x17d7840>;
> 			xlnx,family =3D "virtex2p";
> 			xlnx,gpo-width =3D <0x1>;
> 			xlnx,iic-freq =3D <0x186a0>;
> 			xlnx,scl-inertial-delay =3D <0x0>;
> 			xlnx,sda-inertial-delay =3D <0x0>;
> 			xlnx,ten-bit-adr =3D <0x0>;

Have you checked the values? There is surely

                        #address-cells =3D <1>;
                        #size-cells =3D <0>;

missing here, but that shouldn't cause your problems IMHO. I probably can't
help any further, never used Xilinx so far (you have the newest version of =
the
dts-generator?).

>                         pcf1: iexp@20 {
>                                 #gpio-cells =3D <2>;
>                                 compatible =3D "ti,pcf8574";
>                                 reg =3D <0x20>;
>                                 gpio-controller;
>                         };
> 		} ;
> 		xps_intc_0: interrupt-controller@81800000 {
> 			#interrupt-cells =3D <0x2>;
> 			compatible =3D "xlnx,xps-intc-1.00.a";
> 			interrupt-controller ;
> 			reg =3D < 0x81800000 0x10000 >;
> 			xlnx,num-intr-inputs =3D <0x6>;
> 		} ;
> 		xps_spi_0: xps-spi@81818000 {
> 			compatible =3D "xlnx,xps-spi-2.00.b";
> 			interrupt-parent =3D <&xps_intc_0>;
> 			interrupts =3D < 2 2 >;
> 			reg =3D < 0x81818000 0x80 >;
> 			xlnx,family =3D "virtex2p";
> 			xlnx,fifo-exist =3D <0x1>;
> 			xlnx,num-ss-bits =3D <0x1>;
> 			xlnx,num-transfer-bits =3D <0x8>;
> 			xlnx,sck-ratio =3D <0x20>;
> 			spidev@0 {
> 				compatible =3D "spidev";
> 				spi-max-frequency =3D <1000000>;
> 				reg =3D <0>;
> 			} ;
>=20
> 		} ;
> 	} ;
> 	ppc405_0_dplb1: plb@1 {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		compatible =3D "xlnx,plb-v46-1.03.a", "simple-bus";
> 		ranges ;
> 	} ;
> }  ;


--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAku1J1kACgkQD27XaX1/VRvJNgCghFPalQjgYwOi40JxqtMqpZ3P
5UEAn0lkBzdQfpF/mj9PEJxZek+pFXKW
=n4yx
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
