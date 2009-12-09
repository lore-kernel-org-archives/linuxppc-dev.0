Return-Path: <ajijuni@gmail.com>
MIME-Version: 1.0
In-Reply-To: <507B57E36B7C3A48BD1B90EFA80A782E5372EE795D@GVW0433EXB.americas.hpqcorp.net>
References: <72d214170912090957g3743c63bq48836f6faa4b8269@mail.gmail.com>
	<507B57E36B7C3A48BD1B90EFA80A782E5372EE795D@GVW0433EXB.americas.hpqcorp.net>
Date: Wed, 9 Dec 2009 14:08:06 -0800
Message-ID: <72d214170912091408y8d73314p71447f55fe578f7a@mail.gmail.com>
Subject: Re: dts file for MPC8343EA - cuImage doesn't boot , but uImage with
	DTS shows serial output
From: Junita Ajith <ajijuni@gmail.com>
To: "Lee, Eric" <eric.lee@hp.com>
Content-Type: multipart/alternative; boundary=001636e0ae11dac6d7047a52eceb
Cc: "Linuxppc-dev@lists.ozlabs.org" <Linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636e0ae11dac6d7047a52eceb
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Eric,

1. I did try building with MDS configuration.
2. Removed BCSR section
3. Set u-boot environment variable.

The code boots up in the MPC8349 reference platform and not in the custom
board.
Also I am wondering why the cuImage would not give out any serial output
even, whereas I do see serial out with DTB file passed from u-boot?!!


Screen-shot:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bytes transferred =3D 12288 (3000 hex)
SC3000> bootm 0x2000000 - 0x3000000
## Booting image at 02000000 ...
   Image Name:   Linux-2.6.27.18
   Created:      2009-12-09  21:57:32 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1464261 Bytes =3D  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x0FF9BD48 =3D> set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF25
bd address  =3D 0x0FF9BFC4
memstart    =3D 0x00000000
memsize     =3D 0x10000000
flashstart  =3D 0xFE000000
flashsize   =3D 0x00080000
flashoffset =3D 0x00034000
sramstart   =3D 0x00000000
sramsize    =3D 0x00000000
bootflags   =3D 0x00000001
intfreq     =3D 399.999 MHz
busfreq     =3D 266.666 MHz
ethaddr     =3D 00:E0:0C:00:8C:01
IP addr     =3D 192.168.201.199
baudrate    =3D 115200 bps
Skipping initrd
   Booting using the fdt at 0x3000000
No initrd
## device tree at 0x03000000 ... 0x03002FFF (len=3D12288=3D0x3000)
   Loading Device Tree to 007fc000, end 007fefff ... OK
Updating property '/soc8349@e0000000/ethernet@24000/mac-address' =3D  00 e0=
 0c
00 81Updating property '/soc8349@e0000000/ethernet@24000/local-mac-address'
=3D  00 e0 01Updating property 'timebase-frequency' =3D  03 f9 40 aa
Updating property 'bus-frequency' =3D  0f e5 02 a8
Updating property 'clock-frequency' =3D  17 d7 83 fc
Updating property 'bus-frequency' =3D  0f e5 02 a8
Updating property 'clock-frequency' =3D  0f e5 02 a8
## Transferring control to Linux (at address 00000000) ...
Using MPC834x MDS machine description
Linux version 2.6.27.18 (root@localhost.localdomain) (gcc version 4.1.2) #4
Wed D9Found legacy serial port 0 for /soc8349@e0000000/serial@4500
  mem=3De0004500, taddr=3De0004500, irq=3D0, clk=3D266666664, speed=3D0
Found legacy serial port 1 for /soc8349@e0000000/serial@4600
  mem=3De0004600, taddr=3De0004600, irq=3D0, clk=3D266666664, speed=3D0
console [udbg0] enabled
setup_arch: bootmem
mpc834x_mds_setup_arch()
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus number:
0->0
PCI host bridge /pci@e0008500 (primary) ranges:
 MEM 0x0000000090000000..0x000000009fffffff -> 0x0000000090000000
 MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 Prefetch
  IO 0x00000000e2000000..0x00000000e20fffff -> 0x0000000000000000
Found MPC83xx PCI host bridge at 0x00000000e0008600. Firmware bus number:
0->0
PCI host bridge /pci@e0008600  ranges:
 MEM 0x00000000b0000000..0x00000000bfffffff -> 0x00000000b0000000
 MEM 0x00000000a0000000..0x00000000afffffff -> 0x00000000a0000000 Prefetch
  IO 0x00000000e2100000..0x00000000e21fffff -> 0x0000000000000000
arch: exit
Top of RAM: 0x10000000, Total RAM: 0x10000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00010000
  Normal   0x00010000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00010000
On node 0 totalpages: 65536
free_area_init_node: node 0, pgdat c02ed470, node_mem_map c030f180
  DMA zone: 65024 pages, LIFO batch:15
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=3D/dev/ram rw console=3DttyS0,115200
IPIC (128 IRQ sources) at fddfa700
PID hash table entries: 1024 (order: 10, 4096 bytes)
time_init: decrementer frequency =3D 66.666666 MHz
time_init: processor frequency   =3D 399.999996 MHz
clocksource: timebase mult[3c00001] shift[22] registered
clockevent: decrementer mult[1111] shift[16] cpu[0]
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)



On 12/9/09, Lee, Eric <eric.lee@hp.com> wrote:
>
>  two things; I had better luck with the mpc8349mds (? don=92t remember ex=
act
> file name) dts as opposed to the itx.  I had to remove the bcsr section o=
r
> else the kernel hung during initialization .  also, your u-boot is not
> passing the correct kernel commandline:
>
>
>
> =93Kernel command line: root=3D/dev/nfs rw nfsroot=3D192.168.200.230:/nfs=
root/rootfs
> i0IPIC (128 IRQ sources) at fdffc700=94
>
>
>
> you=92re trying to run a ramdisk and with tty I expect:
>
>
>
> =93root=3D/dev/ram rw console=3DttyS0,115200  =93
>
>
>
> check your environment variable bootargs in u-boot
>
>
>
>
>
>
>
> *From:* Junita Ajith [mailto:ajijuni@gmail.com]
> *Sent:* Wednesday, December 09, 2009 10:58 AM
> *To:* Lee, Eric
> *Cc:* Linuxppc-dev@lists.ozlabs.org
> *Subject:* dts file for MPC8343EA - cuImage doesn't boot , but uImage wit=
h
> DTS shows serial output
>
>
>
> Hi Eric,
>
> I am building the linux kernel V-2.6.27  based on MPC8349miTXGP dts file.
> I am still not able to boot the cuImage.
>
> But, I see serial outuput from kernel when I try to boot with <kernel>
> <ramdisk> <dtb file>
>
> Still the kernel hangs after "Dentry cache hash table entries: 32768
> (order: 5, 131072 bytes)".
>
> Any clues ..?? We have DDR2 in this board and we are initializing it in
> U-Boot.
>
> Please find the screen dump below:
>
> Thanks,
> Junita
>
> Screen shot:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> u-boot> bootm 0x2000000 0x3000000 0x4000000
> ## Booting image at 02000000 ...
>    Image Name:   Linux-2.6.27.18-svn52-dirty8
>    Created:      2009-12-08  23:49:28 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1416039 Bytes =3D  1.4 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Current stack ends at 0x0FF9BD48 =3D> set upper limit to 0x00800000
> ## cmdline at 0x007FFF00 ... 0x007FFFA6
> bd address  =3D 0x0FF9BFC4
> memstart    =3D 0x00000000
> memsize     =3D 0x10000000
> flashstart  =3D 0xFE000000
> flashsize   =3D 0x00080000
> flashoffset =3D 0x00034000
> sramstart   =3D 0x00000000
> sramsize    =3D 0x00000000
> bootflags   =3D 0x00000001
> intfreq     =3D 399.999 MHz
> busfreq     =3D 266.666 MHz
> ethaddr     =3D 00:E0:0C:00:8C:01
> IP addr     =3D 192.168.201.199
> baudrate    =3D 115200 bps
> Not skipping initrd
> ## Loading RAMDisk Image at 03000000 ...
>    Image Name:   uboot ext2 ramdisk rootfs
>    Created:      2009-10-30  20:15:22 UTC
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    3889103 Bytes =3D  3.7 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Booting using the fdt at 0x4000000
> ## initrd at 0x03000040 ... 0x033B580E (len=3D3889103=3D0x3B57CF)
>    Loading Ramdisk to 0fbe5000, end 0ff9a7cf ... OK
> ## device tree at 0x04000000 ... 0x04002FFF (len=3D12288=3D0x3000)
>    Loading Device Tree to 007fc000, end 007fefff ... OK
> Updating property '/soc8349@e0000000/ethernet@24000/mac-address' =3D  00 =
e0
> 0c 001Updating property '/soc8349@e0000000/ethernet@24000/local-mac-addre=
ss'
> =3D  00 e01Updating property 'timebase-frequency' =3D  03 f9 40 aa
> Updating property 'bus-frequency' =3D  0f e5 02 a8
> Updating property 'clock-frequency' =3D  17 d7 83 fc
> Updating property 'bus-frequency' =3D  0f e5 02 a8
> Updating property 'clock-frequency' =3D  0f e5 02 a8
> ## Transferring control to Linux (at address 00000000) ...
> Using MPC834x ITX machine description
> Linux version 2.6.27.18-svn52-dirty8 (root@localhost.localdomain) (gcc
> version 9Found initrd at 0xcfbe5000:0xcff9a7cf
> console [udbg0] enabled
> setup_arch: bootmem
> mpc834x_itx_setup_arch()
> arch: exit
> Zone PFN ranges:
>   DMA      0x00000000 -> 0x00010000
>   Normal   0x00010000 -> 0x00010000
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0: 0x00000000 -> 0x00010000
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 6502=
4
> Kernel command line: root=3D/dev/nfs rw nfsroot=3D192.168.200.230:/nfsroo=
t/rootfs
> i0IPIC (128 IRQ sources) at fdffc700
> PID hash table entries: 1024 (order: 10, 4096 bytes)
> clocksource: timebase mult[3c00001] shift[22] registered
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
>
>
>
>
>  On 12/9/09, *Lee, Eric* <eric.lee@hp.com> wrote:
>
> I would probably remove the bcsr region.  this was some cpld I believe on=
 a
> reference board.  with this dts it'll try to write to some hardware
> registers that do not exist or are not mapped to the same area.
>
>
>
>
> -----Original Message-----
> From: linuxppc-dev-bounces+eric.lee=3Dhp.com@lists.ozlabs.org [mailto:
> linuxppc-dev-bounces+eric.lee <linuxppc-dev-bounces%2Beric.lee>=3Dhp.com@
> lists.ozlabs.org] On Behalf Of ajijuni@gmail.com
> Sent: Sunday, December 06, 2009 11:41 PM
> To: Linuxppc-dev@lists.ozlabs.org
> Subject: dts file for MPC8343EA
>
> Hi
>
> We have an MPC8343EA based custom board.
>
> I am not able to get Linux up and running in this. No serial output to
> debug further.
>   U-boot shows correct 'bdinfo' & 'clocks' output.
> inux hangs at machine_probe.
>
>
> I doubt the DTS file in Linux. anyone has DTS file for MPC8343??
>
> u-boot version - 1.3.2
> linux-2.6.27
> The board base files are drived from MPC8349Imtx-GP since we have the
> reference board in which we tested the linux image.
>
> My current DTS file
> /dts-v1/;
>
> / {
>         model =3D "MPC8343";
>         compatible =3D "MPC8349EMDS", "MPC834xMDS", "MPC83xxMDS";
>         linux,phandle =3D <0x100>;
>         #size-cells =3D <0x1>;
>         #address-cells =3D <0x1>;
>
>         aliases {
>                 ethernet0 =3D &enet0;
>                 ethernet1 =3D &enet1;
>                 serial0 =3D &serial0;
>                 serial1 =3D &serial1;
>                 pci0 =3D &pci0;
>                 pci1 =3D &pci1;
>         };
>          cpus {
>                 linux,phandle =3D <0x200>;
>                 #cpus =3D <0x1>;
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>
>   PowerPC,8343EA@0 {
>                         device_type =3D "cpu";
>                         reg =3D <0x0>;
>                         d-cache-line-size =3D <20>;
>                         i-cache-line-size =3D <20>;
>                         d-cache-size =3D <8000>;
>                         i-cache-size =3D <8000>;
>                         timebase-frequency =3D <0>;       // from bootloa=
der
>                         bus-frequency =3D <0>;            // from bootloa=
der
>                         clock-frequency =3D <0>;          // from bootloa=
der
>                         32-bit;
>                 };
>         };
>
>
>         memory {
>                 device_type =3D "memory";
>                 reg =3D <0x00000000 0x10000000>;  // 256MB at 0
>         };
>
>         bcsr@e2400000 {
>                 device_type =3D "board-control";
>                 reg =3D <0xe2400000 0x8000>;
>         };
>         soc8343@e0000000 {
>                 bus-frequency =3D <0x1>;
>                 reg =3D <0xe0000000 0x200>;
>                 ranges =3D <0x0 0xe0000000 0x100000>;
>                 device_type =3D "soc";
>                 #interrupt-cells =3D <0x2>;
>                 #size-cells =3D <0x1>;
>                 #address-cells =3D <0x1>;
>
>                 wdt@200 {
>                         device_type =3D "watchdog";
>                         compatible =3D "mpc83xx_wdt";
>                         reg =3D <0x200 0x100>;
>                 };
>
> i2c@3000 {
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         cell-index =3D <0>;
>                         compatible =3D "fsl-i2c";
>                         reg =3D <0x3000 0x100>;
>                         interrupts =3D <14 0x8>;
>                         interrupt-parent =3D <&ipic>;
>                         dfsrr;
>
>                         rtc@68 {
>                                 compatible =3D "dallas,ds1374";
>                                 reg =3D <0x68>;
>                         };
>                 };
>
>                 i2c@3100 {
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         cell-index =3D <1>;
>                         compatible =3D "fsl-i2c";
>                         reg =3D <0x3100 0x100>;
>                         interrupts =3D <15 0x8>;
>                         interrupt-parent =3D <&ipic>;
>                         dfsrr;
>                 };
>
>                 spi@7000 {
>                         cell-index =3D <0>;
>                         compatible =3D "fsl,spi";
>                         reg =3D <0x7000 0x1000>;
>                         interrupts =3D <16 0x8>;
>                         interrupt-parent =3D <&ipic>;
>                         mode =3D "cpu";
>                 };
>
> dma@82a8 {
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         compatible =3D "fsl,mpc8349-dma", "fsl,elo-dma";
>                         reg =3D <0x82a8 4>;
>                         ranges =3D <0 0x8100 0x1a8>;
>                         interrupt-parent =3D <&ipic>;
>                         interrupts =3D <71 8>;
>                         cell-index =3D <0>;
>                         dma-channel@0 {
>                                 compatible =3D "fsl,mpc8349-dma-channel",
> "fsl,elo-dma-channel";
>                                 reg =3D <0 0x80>;
>                                 interrupt-parent =3D <&ipic>;
>                                 interrupts =3D <71 8>;
>                         };
>                         dma-channel@80 {
>                                 compatible =3D "fsl,mpc8349-dma-channel",
> "fsl,elo-dma-channel";
>                                 reg =3D <0x80 0x80>;
>                                 interrupt-parent =3D <&ipic>;
>                                 interrupts =3D <71 8>;
>                         };
>                         dma-channel@100 {
>                                 compatible =3D "fsl,mpc8349-dma-channel",
> "fsl,elo-dma-channel";
>                                 reg =3D <0x100 0x80>;
>                                 interrupt-parent =3D <&ipic>;
>                                 interrupts =3D <71 8>;
>                         };
>                         dma-channel@180 {
>                                 compatible =3D "fsl,mpc8349-dma-channel",
> "fsl,elo-dma-channel";
>                                 reg =3D <0x180 0x28>;
>                                 interrupt-parent =3D <&ipic>;
>                                 interrupts =3D <71 8>;
>                         };
>                 };
> /* phy type (ULPI or SERIAL) are only types supported for MPH */
>                 /* port =3D 0 or 1 */
>                 usb@22000 {
>                         compatible =3D "fsl-usb2-mph";
>                         reg =3D <0x22000 0x1000>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         interrupt-parent =3D <&ipic>;
>                         interrupts =3D <39 0x8>;
>                         phy_type =3D "ulpi";
>                         port1;
>                 };
>                 /* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
>                 usb@23000 {
>                         compatible =3D "fsl-usb2-dr";
>                         reg =3D <0x23000 0x1000>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         interrupt-parent =3D <&ipic>;
>                         interrupts =3D <38 0x8>;
>                         dr_mode =3D "otg";
>                         phy_type =3D "ulpi";
>                 };
>
>                 mdio@24520 {
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         compatible =3D "fsl,gianfar-mdio";
>                         reg =3D <0x24520 0x20>;
>
>                         phy0: ethernet-phy@0 {
>                                 interrupt-parent =3D <&ipic>;
>                                 interrupts =3D <17 0x8>;
>                                 reg =3D <0x0>;
>                                 device_type =3D "ethernet-phy";
>                         };
>                         phy1: ethernet-phy@1 {
>                                 interrupt-parent =3D <&ipic>;
>                                 interrupts =3D <18 0x8>;
>                                 reg =3D <0x1>;
>                                 device_type =3D "ethernet-phy";
>                         };
> enet0: ethernet@24000 {
>                         cell-index =3D <0>;
>                         device_type =3D "network";
>                         model =3D "TSEC";
>                         compatible =3D "gianfar";
>                         reg =3D <0x24000 0x1000>;
>                         local-mac-address =3D [ 00 00 00 00 00 00 ];
>                         interrupts =3D <32 0x8 33 0x8 34 0x8>;
>                         interrupt-parent =3D <&ipic>;
>                         phy-handle =3D <&phy0>;
>                         linux,network-index =3D <0>;
>                 };
>
>                 enet1: ethernet@25000 {
>                         cell-index =3D <1>;
>                         device_type =3D "network";
>                         model =3D "TSEC";
>                         compatible =3D "gianfar";
>                         reg =3D <0x25000 0x1000>;
>                         local-mac-address =3D [ 00 00 00 00 00 00 ];
>                         interrupts =3D <35 0x8 36 0x8 37 0x8>;
>                         interrupt-parent =3D <&ipic>;
>                         phy-handle =3D <&phy1>;
>                         linux,network-index =3D <1>;
>                 };
>
> serial0: serial@4500 {
>                         cell-index =3D <0>;
>                         device_type =3D "serial";
>                         compatible =3D "ns16550";
>                         reg =3D <0x4500 0x100>;
>                         clock-frequency =3D <0>;
>                         interrupts =3D <9 0x8>;
>                         interrupt-parent =3D <&ipic>;
>                 };
>
>                 serial1: serial@4600 {
>                         cell-index =3D <1>;
>                         device_type =3D "serial";
>                         compatible =3D "ns16550";
>                         reg =3D <0x4600 0x100>;
>                         clock-frequency =3D <0>;
>                         interrupts =3D <10 0x8>;
>                         interrupt-parent =3D <&ipic>;
>                 };
>
>                 crypto@30000 {
>                         compatible =3D "fsl,sec2.0";
>                         reg =3D <0x30000 0x10000>;
>                         interrupts =3D <11 0x8>;
>                         interrupt-parent =3D <&ipic>;
>                         fsl,num-channels =3D <4>;
>                         fsl,channel-fifo-len =3D <24>;
>                         fsl,exec-units-mask =3D <0x7e>;
>                         fsl,descriptor-types-mask =3D <0x01010ebf>;
>                 };
>
> Thanks,
> agnel
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
>

--001636e0ae11dac6d7047a52eceb
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: base64

RXJpYyw8YnI+Cjxicj4KMS4gSSBkaWQgdHJ5IGJ1aWxkaW5nIHdpdGggTURTIGNvbmZpZ3VyYXRp
b24uPGJyPgoyLiBSZW1vdmVkIEJDU1Igc2VjdGlvbjxicj4KMy4gU2V0IHUtYm9vdCBlbnZpcm9u
bWVudCB2YXJpYWJsZS48YnI+Cjxicj4KVGhlIGNvZGUgYm9vdHMgdXAgaW4gdGhlIE1QQzgzNDkg
cmVmZXJlbmNlIHBsYXRmb3JtIGFuZCBub3QgaW4gdGhlIGN1c3RvbSBib2FyZC48YnI+CkFsc28g
SSBhbSB3b25kZXJpbmcgd2h5IHRoZSBjdUltYWdlIHdvdWxkIG5vdCBnaXZlIG91dCBhbnkgc2Vy
aWFsCm91dHB1dCBldmVuLCB3aGVyZWFzIEkgZG8gc2VlIHNlcmlhbCBvdXQgd2l0aCBEVEIgZmls
ZSBwYXNzZWQgZnJvbQp1LWJvb3Q/ISE8YnI+Cjxicj4KPGJyPgpTY3JlZW4tc2hvdDo8YnI+Cj09
PT09PT09PT08YnI+CkJ5dGVzIHRyYW5zZmVycmVkID0gMTIyODggKDMwMDAgaGV4KTxicj4KU0Mz
MDAwJmd0OyBib290bSAweDIwMDAwMDAgLSAweDMwMDAwMDA8YnI+CiMjIEJvb3RpbmcgaW1hZ2Ug
YXQgMDIwMDAwMDAgLi4uPGJyPgqgoCBJbWFnZSBOYW1lOqCgIExpbnV4LTIuNi4yNy4xODxicj4K
oKAgQ3JlYXRlZDqgoKCgoCAyMDA5LTEyLTA5oCAyMTo1NzozMiBVVEM8YnI+CqCgIEltYWdlIFR5
cGU6oKAgUG93ZXJQQyBMaW51eCBLZXJuZWwgSW1hZ2UgKGd6aXAgY29tcHJlc3NlZCk8YnI+CqCg
IERhdGEgU2l6ZTqgoKAgMTQ2NDI2MSBCeXRlcyA9oCAxLjQgTUI8YnI+CqCgIExvYWQgQWRkcmVz
czogMDAwMDAwMDA8YnI+CqCgIEVudHJ5IFBvaW50OqAgMDAwMDAwMDA8YnI+CqCgIFZlcmlmeWlu
ZyBDaGVja3N1bSAuLi4gT0s8YnI+CqCgIFVuY29tcHJlc3NpbmcgS2VybmVsIEltYWdlIC4uLiBP
Szxicj4KIyMgQ3VycmVudCBzdGFjayBlbmRzIGF0IDB4MEZGOUJENDggPSZndDsgc2V0IHVwcGVy
IGxpbWl0IHRvIDB4MDA4MDAwMDA8YnI+CiMjIGNtZGxpbmUgYXQgMHgwMDdGRkYwMCAuLi4gMHgw
MDdGRkYyNTxicj4KYmQgYWRkcmVzc6AgPSAweDBGRjlCRkM0PGJyPgptZW1zdGFydKCgoCA9IDB4
MDAwMDAwMDA8YnI+Cm1lbXNpemWgoKCgID0gMHgxMDAwMDAwMDxicj4KZmxhc2hzdGFydKAgPSAw
eEZFMDAwMDAwPGJyPgpmbGFzaHNpemWgoCA9IDB4MDAwODAwMDA8YnI+CmZsYXNob2Zmc2V0ID0g
MHgwMDAzNDAwMDxicj4Kc3JhbXN0YXJ0oKAgPSAweDAwMDAwMDAwPGJyPgpzcmFtc2l6ZaCgoCA9
IDB4MDAwMDAwMDA8YnI+CmJvb3RmbGFnc6CgID0gMHgwMDAwMDAwMTxicj4KaW50ZnJlcaCgoKAg
PSAzOTkuOTk5IE1Iejxicj4KYnVzZnJlcaCgoKAgPSAyNjYuNjY2IE1Iejxicj4KZXRoYWRkcqCg
oKAgPSAwMDpFMDowQzowMDo4QzowMTxicj4KSVAgYWRkcqCgoKAgPSAxOTIuMTY4LjIwMS4xOTk8
YnI+CmJhdWRyYXRloKCgID0gMTE1MjAwIGJwczxicj4KU2tpcHBpbmcgaW5pdHJkPGJyPgqgoCBC
b290aW5nIHVzaW5nIHRoZSBmZHQgYXQgMHgzMDAwMDAwPGJyPgpObyBpbml0cmQ8YnI+CiMjIGRl
dmljZSB0cmVlIGF0IDB4MDMwMDAwMDAgLi4uIDB4MDMwMDJGRkYgKGxlbj0xMjI4OD0weDMwMDAp
PGJyPgqgoCBMb2FkaW5nIERldmljZSBUcmVlIHRvIDAwN2ZjMDAwLCBlbmQgMDA3ZmVmZmYgLi4u
IE9LPGJyPgpVcGRhdGluZyBwcm9wZXJ0eSAmIzM5Oy9zb2M4MzQ5QGUwMDAwMDAwL2V0aGVybmV0
QDI0MDAwL21hYy1hZGRyZXNzJiMzOTsKPaAgMDAgZTAgMGMgMDAgODFVcGRhdGluZyBwcm9wZXJ0
eQomIzM5Oy9zb2M4MzQ5QGUwMDAwMDAwL2V0aGVybmV0QDI0MDAwL2xvY2FsLW1hYy1hZGRyZXNz
JiMzOTsgPaAgMDAgZTAKMDFVcGRhdGluZyBwcm9wZXJ0eSAmIzM5O3RpbWViYXNlLWZyZXF1ZW5j
eSYjMzk7ID2gIDAzIGY5IDQwIGFhPGJyPgpVcGRhdGluZyBwcm9wZXJ0eSAmIzM5O2J1cy1mcmVx
dWVuY3kmIzM5OyA9oCAwZiBlNSAwMiBhODxicj4KVXBkYXRpbmcgcHJvcGVydHkgJiMzOTtjbG9j
ay1mcmVxdWVuY3kmIzM5OyA9oCAxNyBkNyA4MyBmYzxicj4KVXBkYXRpbmcgcHJvcGVydHkgJiMz
OTtidXMtZnJlcXVlbmN5JiMzOTsgPaAgMGYgZTUgMDIgYTg8YnI+ClVwZGF0aW5nIHByb3BlcnR5
ICYjMzk7Y2xvY2stZnJlcXVlbmN5JiMzOTsgPaAgMGYgZTUgMDIgYTg8YnI+CiMjIFRyYW5zZmVy
cmluZyBjb250cm9sIHRvIExpbnV4IChhdCBhZGRyZXNzIDAwMDAwMDAwKSAuLi48YnI+ClVzaW5n
IE1QQzgzNHggTURTIG1hY2hpbmUgZGVzY3JpcHRpb248YnI+CkxpbnV4IHZlcnNpb24gMi42LjI3
LjE4IChyb290QGxvY2FsaG9zdC5sb2NhbGRvbWFpbikgKGdjYyB2ZXJzaW9uCjQuMS4yKSAjNCBX
ZWQgRDlGb3VuZCBsZWdhY3kgc2VyaWFsIHBvcnQgMCBmb3IKL3NvYzgzNDlAZTAwMDAwMDAvc2Vy
aWFsQDQ1MDA8YnI+CqAgbWVtPWUwMDA0NTAwLCB0YWRkcj1lMDAwNDUwMCwgaXJxPTAsIGNsaz0y
NjY2NjY2NjQsIHNwZWVkPTA8YnI+CkZvdW5kIGxlZ2FjeSBzZXJpYWwgcG9ydCAxIGZvciAvc29j
ODM0OUBlMDAwMDAwMC9zZXJpYWxANDYwMDxicj4KoCBtZW09ZTAwMDQ2MDAsIHRhZGRyPWUwMDA0
NjAwLCBpcnE9MCwgY2xrPTI2NjY2NjY2NCwgc3BlZWQ9MDxicj4KY29uc29sZSBbdWRiZzBdIGVu
YWJsZWQ8YnI+CnNldHVwX2FyY2g6IGJvb3RtZW08YnI+Cm1wYzgzNHhfbWRzX3NldHVwX2FyY2go
KTxicj4KRm91bmQgTVBDODN4eCBQQ0kgaG9zdCBicmlkZ2UgYXQgMHgwMDAwMDAwMGUwMDA4NTAw
LiBGaXJtd2FyZSBidXMgbnVtYmVyOiAwLSZndDswPGJyPgpQQ0kgaG9zdCBicmlkZ2UgL3BjaUBl
MDAwODUwMCAocHJpbWFyeSkgcmFuZ2VzOjxicj4KoE1FTSAweDAwMDAwMDAwOTAwMDAwMDAuLjB4
MDAwMDAwMDA5ZmZmZmZmZiAtJmd0OyAweDAwMDAwMDAwOTAwMDAwMDA8YnI+CqBNRU0gMHgwMDAw
MDAwMDgwMDAwMDAwLi4weDAwMDAwMDAwOGZmZmZmZmYgLSZndDsgMHgwMDAwMDAwMDgwMDAwMDAw
IFByZWZldGNoPGJyPgqgIElPIDB4MDAwMDAwMDBlMjAwMDAwMC4uMHgwMDAwMDAwMGUyMGZmZmZm
IC0mZ3Q7IDB4MDAwMDAwMDAwMDAwMDAwMDxicj4KRm91bmQgTVBDODN4eCBQQ0kgaG9zdCBicmlk
Z2UgYXQgMHgwMDAwMDAwMGUwMDA4NjAwLiBGaXJtd2FyZSBidXMgbnVtYmVyOiAwLSZndDswPGJy
PgpQQ0kgaG9zdCBicmlkZ2UgL3BjaUBlMDAwODYwMKAgcmFuZ2VzOjxicj4KoE1FTSAweDAwMDAw
MDAwYjAwMDAwMDAuLjB4MDAwMDAwMDBiZmZmZmZmZiAtJmd0OyAweDAwMDAwMDAwYjAwMDAwMDA8
YnI+CqBNRU0gMHgwMDAwMDAwMGEwMDAwMDAwLi4weDAwMDAwMDAwYWZmZmZmZmYgLSZndDsgMHgw
MDAwMDAwMGEwMDAwMDAwIFByZWZldGNoPGJyPgqgIElPIDB4MDAwMDAwMDBlMjEwMDAwMC4uMHgw
MDAwMDAwMGUyMWZmZmZmIC0mZ3Q7IDB4MDAwMDAwMDAwMDAwMDAwMDxicj4KYXJjaDogZXhpdDxi
cj4KVG9wIG9mIFJBTTogMHgxMDAwMDAwMCwgVG90YWwgUkFNOiAweDEwMDAwMDAwPGJyPgpNZW1v
cnkgaG9sZSBzaXplOiAwTUI8YnI+ClpvbmUgUEZOIHJhbmdlczo8YnI+CqAgRE1BoKCgoKAgMHgw
MDAwMDAwMCAtJmd0OyAweDAwMDEwMDAwPGJyPgqgIE5vcm1hbKCgIDB4MDAwMTAwMDAgLSZndDsg
MHgwMDAxMDAwMDxicj4KTW92YWJsZSB6b25lIHN0YXJ0IFBGTiBmb3IgZWFjaCBub2RlPGJyPgpl
YXJseV9ub2RlX21hcFsxXSBhY3RpdmUgUEZOIHJhbmdlczxicj4KoKCgIDA6IDB4MDAwMDAwMDAg
LSZndDsgMHgwMDAxMDAwMDxicj4KT24gbm9kZSAwIHRvdGFscGFnZXM6IDY1NTM2PGJyPgpmcmVl
X2FyZWFfaW5pdF9ub2RlOiBub2RlIDAsIHBnZGF0IGMwMmVkNDcwLCBub2RlX21lbV9tYXAgYzAz
MGYxODA8YnI+CqAgRE1BIHpvbmU6IDY1MDI0IHBhZ2VzLCBMSUZPIGJhdGNoOjE1PGJyPgpCdWls
dCAxIHpvbmVsaXN0cyBpbiBab25lIG9yZGVyLCBtb2JpbGl0eSBncm91cGluZyBvbi6gIFRvdGFs
IHBhZ2VzOiA2NTAyNDxicj4KS2VybmVsIGNvbW1hbmQgbGluZTogcm9vdD0vZGV2L3JhbSBydyBj
b25zb2xlPXR0eVMwLDExNTIwMDxicj4KSVBJQyAoMTI4IElSUSBzb3VyY2VzKSBhdCBmZGRmYTcw
MDxicj4KUElEIGhhc2ggdGFibGUgZW50cmllczogMTAyNCAob3JkZXI6IDEwLCA0MDk2IGJ5dGVz
KTxicj4KdGltZV9pbml0OiBkZWNyZW1lbnRlciBmcmVxdWVuY3kgPSA2Ni42NjY2NjYgTUh6PGJy
Pgp0aW1lX2luaXQ6IHByb2Nlc3NvciBmcmVxdWVuY3mgoCA9IDM5OS45OTk5OTYgTUh6PGJyPgpj
bG9ja3NvdXJjZTogdGltZWJhc2UgbXVsdFszYzAwMDAxXSBzaGlmdFsyMl0gcmVnaXN0ZXJlZDxi
cj4KY2xvY2tldmVudDogZGVjcmVtZW50ZXIgbXVsdFsxMTExXSBzaGlmdFsxNl0gY3B1WzBdPGJy
PgpEZW50cnkgY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAzMjc2OCAob3JkZXI6IDUsIDEzMTA3
MiBieXRlcyk8YnI+Cjxicj4KPGJyPjxicj48ZGl2PjxzcGFuIGNsYXNzPSJnbWFpbF9xdW90ZSI+
T24gMTIvOS8wOSwgPGIgY2xhc3M9ImdtYWlsX3NlbmRlcm5hbWUiPkxlZSwgRXJpYzwvYj4gJmx0
OzxhIGhyZWY9Im1haWx0bzplcmljLmxlZUBocC5jb20iPmVyaWMubGVlQGhwLmNvbTwvYT4mZ3Q7
IHdyb3RlOjwvc3Bhbj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJib3Jk
ZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgbWFyZ2luOiAwcHQgMHB0IDBw
dCAwLjhleDsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KCgoKCgoKCgoKPGRpdiBsaW5rPSJibHVlIiB2
bGluaz0icHVycGxlIiBsYW5nPSJFTi1VUyI+Cgo8ZGl2PgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+
PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTFwdDsgY29sb3I6IHJnYigzMSwgNzMsIDEyNSk7Ij50
d28gdGhpbmdzOyBJIGhhZCBiZXR0ZXIgbHVjayB3aXRoIHRoZSBtcGM4MzQ5bWRzICg/IGRvbpJ0
CnJlbWVtYmVyIGV4YWN0IGZpbGUgbmFtZSkgZHRzIGFzIG9wcG9zZWQgdG8gdGhlIGl0eC6gIEkg
aGFkIHRvIHJlbW92ZSB0aGUgYmNzcgpzZWN0aW9uIG9yIGVsc2UgdGhlIGtlcm5lbCBodW5nIGR1
cmluZyBpbml0aWFsaXphdGlvbiAuoCBhbHNvLCB5b3VyIHUtYm9vdCBpcwpub3QgcGFzc2luZyB0
aGUgY29ycmVjdCBrZXJuZWwgY29tbWFuZGxpbmU6PC9zcGFuPjwvcD4KCjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDExcHQ7IGNvbG9yOiByZ2IoMzEsIDczLCAx
MjUpOyI+oDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9u
dC1zaXplOiAxMXB0OyBjb2xvcjogcmdiKDMxLCA3MywgMTI1KTsiPpM8L3NwYW4+S2VybmVsIGNv
bW1hbmQgbGluZTogcm9vdD0vZGV2L25mcyBydwpuZnNyb290PTE5Mi4xNjguMjAwLjIzMDovbmZz
cm9vdC9yb290ZnMgaTBJUElDICgxMjggSVJRIHNvdXJjZXMpIGF0IGZkZmZjNzAwlDwvcD4KCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPqA8L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj55b3WScmUgdHJ5
aW5nIHRvIHJ1biBhIHJhbWRpc2sgYW5kIHdpdGggdHR5IEkgZXhwZWN0OjwvcD4KCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPqA8L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9u
dC1zaXplOiAxMXB0OyBjb2xvcjogcmdiKDMxLCA3MywgMTI1KTsiPpNyb290PS9kZXYvcmFtIHJ3
IGNvbnNvbGU9dHR5UzAsMTE1MjAwoCCTPC9zcGFuPjwvcD4KCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDExcHQ7IGNvbG9yOiByZ2IoMzEsIDczLCAxMjUpOyI+
oDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXpl
OiAxMXB0OyBjb2xvcjogcmdiKDMxLCA3MywgMTI1KTsiPmNoZWNrIHlvdXIgZW52aXJvbm1lbnQg
dmFyaWFibGUgYm9vdGFyZ3MgaW4gdS1ib290PC9zcGFuPjwvcD4KCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDExcHQ7IGNvbG9yOiByZ2IoMzEsIDczLCAxMjUp
OyI+oDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOiAxMXB0OyBjb2xvcjogcmdiKDMxLCA3MywgMTI1KTsiPqA8L3NwYW4+PC9wPgoKPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTFwdDsgY29sb3I6IHJnYigz
MSwgNzMsIDEyNSk7Ij6gPC9zcGFuPjwvcD4KCjxkaXYgc3R5bGU9ImJvcmRlci1zdHlsZTogc29s
aWQgbm9uZSBub25lOyBib3JkZXItY29sb3I6IHJnYigxODEsIDE5NiwgMjIzKSAtbW96LXVzZS10
ZXh0LWNvbG9yIC1tb3otdXNlLXRleHQtY29sb3I7IGJvcmRlci13aWR0aDogMXB0IG1lZGl1bSBt
ZWRpdW07IHBhZGRpbmc6IDNwdCAwaW4gMGluOyI+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48Yj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyI+RnJvbTo8L3NwYW4+PC9iPjxzcGFuIHN0eWxl
PSJmb250LXNpemU6IDEwcHQ7Ij4gSnVuaXRhIEFqaXRoClttYWlsdG86PGEgaHJlZj0ibWFpbHRv
OmFqaWp1bmlAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayIgb25jbGljaz0icmV0dXJuIHRvcC5q
cy5PcGVuRXh0TGluayh3aW5kb3csZXZlbnQsdGhpcykiPmFqaWp1bmlAZ21haWwuY29tPC9hPl0g
PGJyPgo8Yj5TZW50OjwvYj4gV2VkbmVzZGF5LCBEZWNlbWJlciAwOSwgMjAwOSAxMDo1OCBBTTxi
cj4KPGI+VG86PC9iPiBMZWUsIEVyaWM8YnI+CjxiPkNjOjwvYj4gPGEgaHJlZj0ibWFpbHRvOkxp
bnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnIiB0YXJnZXQ9Il9ibGFuayIgb25jbGljaz0icmV0
dXJuIHRvcC5qcy5PcGVuRXh0TGluayh3aW5kb3csZXZlbnQsdGhpcykiPkxpbnV4cHBjLWRldkBs
aXN0cy5vemxhYnMub3JnPC9hPjxicj4KPGI+U3ViamVjdDo8L2I+IGR0cyBmaWxlIGZvciBNUEM4
MzQzRUEgLSBjdUltYWdlIGRvZXNuJiMzOTt0IGJvb3QgLCBidXQgdUltYWdlIHdpdGgKRFRTIHNo
b3dzIHNlcmlhbCBvdXRwdXQ8L3NwYW4+PC9wPgoKPC9kaXY+PGRpdj48c3BhbiBjbGFzcz0iZSIg
aWQ9InFfMTI1NzRhNGZjZWM3Y2M3Zl8xIj4KCjxwIGNsYXNzPSJNc29Ob3JtYWwiPqA8L3A+Cgo8
cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbTogMTJwdDsiPkhpIEVyaWMs
PGJyPgo8YnI+CkkgYW0gYnVpbGRpbmcgdGhlIGxpbnV4IGtlcm5lbCBWLTIuNi4yN6AgYmFzZWQg
b24gTVBDODM0OW1pVFhHUCBkdHMgZmlsZS48YnI+CkkgYW0gc3RpbGwgbm90IGFibGUgdG8gYm9v
dCB0aGUgY3VJbWFnZS48YnI+Cjxicj4KQnV0LCBJIHNlZSBzZXJpYWwgb3V0dXB1dCBmcm9tIGtl
cm5lbCB3aGVuIEkgdHJ5IHRvIGJvb3Qgd2l0aCAmbHQ7a2VybmVsJmd0OwombHQ7cmFtZGlzayZn
dDsgJmx0O2R0YiBmaWxlJmd0Ozxicj4KPGJyPgpTdGlsbCB0aGUga2VybmVsIGhhbmdzIGFmdGVy
ICZxdW90O0RlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDMyNzY4CihvcmRlcjogNSwg
MTMxMDcyIGJ5dGVzKSZxdW90Oy48YnI+Cjxicj4KQW55IGNsdWVzIC4uPz8gV2UgaGF2ZSBERFIy
IGluIHRoaXMgYm9hcmQgYW5kIHdlIGFyZSBpbml0aWFsaXppbmcgaXQgaW4gVS1Cb290Lgo8YnI+
Cjxicj4KUGxlYXNlIGZpbmQgdGhlIHNjcmVlbiBkdW1wIGJlbG93Ojxicj4KPGJyPgpUaGFua3Ms
PGJyPgpKdW5pdGE8YnI+Cjxicj4KU2NyZWVuIHNob3Q6PGJyPgo9PT09PT09PT09PTxicj4KdS1i
b290Jmd0OyBib290bSAweDIwMDAwMDAgMHgzMDAwMDAwIDB4NDAwMDAwMDxicj4KIyMgQm9vdGlu
ZyBpbWFnZSBhdCAwMjAwMDAwMCAuLi48YnI+CqCgIEltYWdlIE5hbWU6oKAgTGludXgtMi42LjI3
LjE4LXN2bjUyLWRpcnR5ODxicj4KoKAgQ3JlYXRlZDqgoKCgoCAyMDA5LTEyLTA4oCAyMzo0OToy
OApVVEM8YnI+CqCgIEltYWdlIFR5cGU6oKAgUG93ZXJQQyBMaW51eCBLZXJuZWwgSW1hZ2UgKGd6
aXAKY29tcHJlc3NlZCk8YnI+CqCgIERhdGEgU2l6ZTqgoKAgMTQxNjAzOSBCeXRlcyA9oCAxLjQg
TUI8YnI+CqCgIExvYWQgQWRkcmVzczogMDAwMDAwMDA8YnI+CqCgIEVudHJ5IFBvaW50OqAgMDAw
MDAwMDA8YnI+CqCgIFZlcmlmeWluZyBDaGVja3N1bSAuLi4gT0s8YnI+CqCgIFVuY29tcHJlc3Np
bmcgS2VybmVsIEltYWdlIC4uLiBPSzxicj4KIyMgQ3VycmVudCBzdGFjayBlbmRzIGF0IDB4MEZG
OUJENDggPSZndDsgc2V0IHVwcGVyIGxpbWl0IHRvIDB4MDA4MDAwMDA8YnI+CiMjIGNtZGxpbmUg
YXQgMHgwMDdGRkYwMCAuLi4gMHgwMDdGRkZBNjxicj4KYmQgYWRkcmVzc6AgPSAweDBGRjlCRkM0
PGJyPgptZW1zdGFydKCgoCA9IDB4MDAwMDAwMDA8YnI+Cm1lbXNpemWgoKCgID0gMHgxMDAwMDAw
MDxicj4KZmxhc2hzdGFydKAgPSAweEZFMDAwMDAwPGJyPgpmbGFzaHNpemWgoCA9IDB4MDAwODAw
MDA8YnI+CmZsYXNob2Zmc2V0ID0gMHgwMDAzNDAwMDxicj4Kc3JhbXN0YXJ0oKAgPSAweDAwMDAw
MDAwPGJyPgpzcmFtc2l6ZaCgoCA9IDB4MDAwMDAwMDA8YnI+CmJvb3RmbGFnc6CgID0gMHgwMDAw
MDAwMTxicj4KaW50ZnJlcaCgoKAgPSAzOTkuOTk5IE1Iejxicj4KYnVzZnJlcaCgoKAgPSAyNjYu
NjY2IE1Iejxicj4KZXRoYWRkcqCgoKAgPSAwMDpFMDowQzowMDo4QzowMTxicj4KSVAgYWRkcqCg
oKAgPSAxOTIuMTY4LjIwMS4xOTk8YnI+CmJhdWRyYXRloKCgID0gMTE1MjAwIGJwczxicj4KTm90
IHNraXBwaW5nIGluaXRyZDxicj4KIyMgTG9hZGluZyBSQU1EaXNrIEltYWdlIGF0IDAzMDAwMDAw
IC4uLjxicj4KoKAgSW1hZ2UgTmFtZTqgoCB1Ym9vdCBleHQyIHJhbWRpc2sgcm9vdGZzPGJyPgqg
oCBDcmVhdGVkOqCgoKCgIDIwMDktMTAtMzCgIDIwOjE1OjIyClVUQzxicj4KoKAgSW1hZ2UgVHlw
ZTqgoCBQb3dlclBDIExpbnV4IFJBTURpc2sgSW1hZ2UgKGd6aXAKY29tcHJlc3NlZCk8YnI+CqCg
IERhdGEgU2l6ZTqgoKAgMzg4OTEwMyBCeXRlcyA9oCAzLjcgTUI8YnI+CqCgIExvYWQgQWRkcmVz
czogMDAwMDAwMDA8YnI+CqCgIEVudHJ5IFBvaW50OqAgMDAwMDAwMDA8YnI+CqCgIFZlcmlmeWlu
ZyBDaGVja3N1bSAuLi4gT0s8YnI+CqCgIEJvb3RpbmcgdXNpbmcgdGhlIGZkdCBhdCAweDQwMDAw
MDA8YnI+CiMjIGluaXRyZCBhdCAweDAzMDAwMDQwIC4uLiAweDAzM0I1ODBFIChsZW49Mzg4OTEw
Mz0weDNCNTdDRik8YnI+CqCgIExvYWRpbmcgUmFtZGlzayB0byAwZmJlNTAwMCwgZW5kIDBmZjlh
N2NmIC4uLiBPSzxicj4KIyMgZGV2aWNlIHRyZWUgYXQgMHgwNDAwMDAwMCAuLi4gMHgwNDAwMkZG
RiAobGVuPTEyMjg4PTB4MzAwMCk8YnI+CqCgIExvYWRpbmcgRGV2aWNlIFRyZWUgdG8gMDA3ZmMw
MDAsIGVuZCAwMDdmZWZmZiAuLi4gT0s8YnI+ClVwZGF0aW5nIHByb3BlcnR5ICYjMzk7L3NvYzgz
NDlAZTAwMDAwMDAvZXRoZXJuZXRAMjQwMDAvbWFjLWFkZHJlc3MmIzM5OyA9oCAwMCBlMAowYyAw
MDFVcGRhdGluZyBwcm9wZXJ0eSAmIzM5Oy9zb2M4MzQ5QGUwMDAwMDAwL2V0aGVybmV0QDI0MDAw
L2xvY2FsLW1hYy1hZGRyZXNzJiMzOTsKPaAgMDAgZTAxVXBkYXRpbmcgcHJvcGVydHkgJiMzOTt0
aW1lYmFzZS1mcmVxdWVuY3kmIzM5OyA9oCAwMyBmOSA0MCBhYTxicj4KVXBkYXRpbmcgcHJvcGVy
dHkgJiMzOTtidXMtZnJlcXVlbmN5JiMzOTsgPaAgMGYgZTUgMDIgYTg8YnI+ClVwZGF0aW5nIHBy
b3BlcnR5ICYjMzk7Y2xvY2stZnJlcXVlbmN5JiMzOTsgPaAgMTcgZDcgODMgZmM8YnI+ClVwZGF0
aW5nIHByb3BlcnR5ICYjMzk7YnVzLWZyZXF1ZW5jeSYjMzk7ID2gIDBmIGU1IDAyIGE4PGJyPgpV
cGRhdGluZyBwcm9wZXJ0eSAmIzM5O2Nsb2NrLWZyZXF1ZW5jeSYjMzk7ID2gIDBmIGU1IDAyIGE4
PGJyPgojIyBUcmFuc2ZlcnJpbmcgY29udHJvbCB0byBMaW51eCAoYXQgYWRkcmVzcyAwMDAwMDAw
MCkgLi4uPGJyPgpVc2luZyBNUEM4MzR4IElUWCBtYWNoaW5lIGRlc2NyaXB0aW9uPGJyPgpMaW51
eCB2ZXJzaW9uIDIuNi4yNy4xOC1zdm41Mi1kaXJ0eTggKHJvb3RAbG9jYWxob3N0LmxvY2FsZG9t
YWluKSAoZ2NjIHZlcnNpb24KOUZvdW5kIGluaXRyZCBhdCAweGNmYmU1MDAwOjB4Y2ZmOWE3Y2Y8
YnI+CmNvbnNvbGUgW3VkYmcwXSBlbmFibGVkPGJyPgpzZXR1cF9hcmNoOiBib290bWVtPGJyPgpt
cGM4MzR4X2l0eF9zZXR1cF9hcmNoKCk8YnI+CmFyY2g6IGV4aXQ8YnI+ClpvbmUgUEZOIHJhbmdl
czo8YnI+CqAgRE1BoKCgoKAgMHgwMDAwMDAwMCAtJmd0OyAweDAwMDEwMDAwPGJyPgqgIE5vcm1h
bKCgIDB4MDAwMTAwMDAgLSZndDsgMHgwMDAxMDAwMDxicj4KTW92YWJsZSB6b25lIHN0YXJ0IFBG
TiBmb3IgZWFjaCBub2RlPGJyPgplYXJseV9ub2RlX21hcFsxXSBhY3RpdmUgUEZOIHJhbmdlczxi
cj4KoKCgIDA6IDB4MDAwMDAwMDAgLSZndDsgMHgwMDAxMDAwMDxicj4KQnVpbHQgMSB6b25lbGlz
dHMgaW4gWm9uZSBvcmRlciwgbW9iaWxpdHkgZ3JvdXBpbmcgb24uoCBUb3RhbCBwYWdlczogNjUw
MjQ8YnI+Cktlcm5lbCBjb21tYW5kIGxpbmU6IHJvb3Q9L2Rldi9uZnMgcncgbmZzcm9vdD0xOTIu
MTY4LjIwMC4yMzA6L25mc3Jvb3Qvcm9vdGZzCmkwSVBJQyAoMTI4IElSUSBzb3VyY2VzKSBhdCBm
ZGZmYzcwMDxicj4KUElEIGhhc2ggdGFibGUgZW50cmllczogMTAyNCAob3JkZXI6IDEwLCA0MDk2
IGJ5dGVzKTxicj4KY2xvY2tzb3VyY2U6IHRpbWViYXNlIG11bHRbM2MwMDAwMV0gc2hpZnRbMjJd
IHJlZ2lzdGVyZWQ8YnI+CkRlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDMyNzY4IChv
cmRlcjogNSwgMTMxMDcyIGJ5dGVzKTxicj4KPGJyPgo8YnI+Cjxicj4KPGJyPgo8L3A+Cgo8ZGl2
PgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4+T24gMTIvOS8wOSwgPGI+TGVlLCBFcmljPC9i
PiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmVyaWMubGVlQGhwLmNvbSIgdGFyZ2V0PSJfYmxhbmsiIG9u
Y2xpY2s9InJldHVybiB0b3AuanMuT3BlbkV4dExpbmsod2luZG93LGV2ZW50LHRoaXMpIj5lcmlj
LmxlZUBocC5jb208L2E+Jmd0OyB3cm90ZTo8L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1h
bCI+SSB3b3VsZCBwcm9iYWJseSByZW1vdmUgdGhlIGJjc3IgcmVnaW9uLqCgdGhpcyB3YXMKc29t
ZSBjcGxkIEkgYmVsaWV2ZSBvbiBhIHJlZmVyZW5jZSBib2FyZC6goHdpdGggdGhpcyBkdHMgaXQm
IzM5O2xsIHRyeSB0bwp3cml0ZSB0byBzb21lIGhhcmR3YXJlIHJlZ2lzdGVycyB0aGF0IGRvIG5v
dCBleGlzdCBvciBhcmUgbm90IG1hcHBlZCB0byB0aGUKc2FtZSBhcmVhLjxicj4KPGJyPgo8YnI+
Cjxicj4KPGJyPgotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLTxicj4KRnJvbTogbGludXhwcGMt
ZGV2LWJvdW5jZXMrZXJpYy5sZWU9PGEgaHJlZj0iaHR0cDovL2hwLmNvbSIgdGFyZ2V0PSJfYmxh
bmsiIG9uY2xpY2s9InJldHVybiB0b3AuanMuT3BlbkV4dExpbmsod2luZG93LGV2ZW50LHRoaXMp
Ij5ocC5jb208L2E+QDxhIGhyZWY9Imh0dHA6Ly9saXN0cy5vemxhYnMub3JnIiB0YXJnZXQ9Il9i
bGFuayIgb25jbGljaz0icmV0dXJuIHRvcC5qcy5PcGVuRXh0TGluayh3aW5kb3csZXZlbnQsdGhp
cykiPmxpc3RzLm96bGFicy5vcmc8L2E+IFttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmxpbnV4cHBj
LWRldi1ib3VuY2VzJTJCZXJpYy5sZWUiIHRhcmdldD0iX2JsYW5rIiBvbmNsaWNrPSJyZXR1cm4g
dG9wLmpzLk9wZW5FeHRMaW5rKHdpbmRvdyxldmVudCx0aGlzKSI+bGludXhwcGMtZGV2LWJvdW5j
ZXMrZXJpYy5sZWU8L2E+PTxhIGhyZWY9Imh0dHA6Ly9ocC5jb20iIHRhcmdldD0iX2JsYW5rIiBv
bmNsaWNrPSJyZXR1cm4gdG9wLmpzLk9wZW5FeHRMaW5rKHdpbmRvdyxldmVudCx0aGlzKSI+aHAu
Y29tPC9hPkA8YSBocmVmPSJodHRwOi8vbGlzdHMub3psYWJzLm9yZyIgdGFyZ2V0PSJfYmxhbmsi
IG9uY2xpY2s9InJldHVybiB0b3AuanMuT3BlbkV4dExpbmsod2luZG93LGV2ZW50LHRoaXMpIj5s
aXN0cy5vemxhYnMub3JnPC9hPl0KT24gQmVoYWxmIE9mIDxhIGhyZWY9Im1haWx0bzphamlqdW5p
QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiIG9uY2xpY2s9InJldHVybiB0b3AuanMuT3BlbkV4
dExpbmsod2luZG93LGV2ZW50LHRoaXMpIj5hamlqdW5pQGdtYWlsLmNvbTwvYT48YnI+ClNlbnQ6
IFN1bmRheSwgRGVjZW1iZXIgMDYsIDIwMDkgMTE6NDEgUE08YnI+ClRvOiA8YSBocmVmPSJtYWls
dG86TGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmciIHRhcmdldD0iX2JsYW5rIiBvbmNsaWNr
PSJyZXR1cm4gdG9wLmpzLk9wZW5FeHRMaW5rKHdpbmRvdyxldmVudCx0aGlzKSI+TGludXhwcGMt
ZGV2QGxpc3RzLm96bGFicy5vcmc8L2E+PGJyPgpTdWJqZWN0OiBkdHMgZmlsZSBmb3IgTVBDODM0
M0VBPGJyPgo8YnI+CkhpPGJyPgo8YnI+CldlIGhhdmUgYW4gTVBDODM0M0VBIGJhc2VkIGN1c3Rv
bSBib2FyZC48YnI+Cjxicj4KSSBhbSBub3QgYWJsZSB0byBnZXQgTGludXggdXAgYW5kIHJ1bm5p
bmcgaW4gdGhpcy4gTm8gc2VyaWFsIG91dHB1dCB0byBkZWJ1ZwpmdXJ0aGVyLjxicj4KoKBVLWJv
b3Qgc2hvd3MgY29ycmVjdCAmIzM5O2JkaW5mbyYjMzk7ICZhbXA7ICYjMzk7Y2xvY2tzJiMzOTsg
b3V0cHV0Ljxicj4KaW51eCBoYW5ncyBhdCBtYWNoaW5lX3Byb2JlLjxicj4KPGJyPgo8YnI+Ckkg
ZG91YnQgdGhlIERUUyBmaWxlIGluIExpbnV4LiBhbnlvbmUgaGFzIERUUyBmaWxlIGZvciBNUEM4
MzQzPz88YnI+Cjxicj4KdS1ib290IHZlcnNpb24gLSAxLjMuMjxicj4KbGludXgtMi42LjI3PGJy
PgpUaGUgYm9hcmQgYmFzZSBmaWxlcyBhcmUgZHJpdmVkIGZyb20gTVBDODM0OUltdHgtR1Agc2lu
Y2Ugd2UgaGF2ZSB0aGUgcmVmZXJlbmNlCmJvYXJkIGluIHdoaWNoIHdlIHRlc3RlZCB0aGUgbGlu
dXggaW1hZ2UuPGJyPgo8YnI+Ck15IGN1cnJlbnQgRFRTIGZpbGU8YnI+Ci9kdHMtdjEvOzxicj4K
PGJyPgovIHs8YnI+CqCgoKCgoKCgbW9kZWwgPSAmcXVvdDtNUEM4MzQzJnF1b3Q7Ozxicj4KoKCg
oKCgoKBjb21wYXRpYmxlID0KJnF1b3Q7TVBDODM0OUVNRFMmcXVvdDssICZxdW90O01QQzgzNHhN
RFMmcXVvdDssICZxdW90O01QQzgzeHhNRFMmcXVvdDs7PGJyPgqgoKCgoKCgoGxpbnV4LHBoYW5k
bGUgPSAmbHQ7MHgxMDAmZ3Q7Ozxicj4KoKCgoKCgoKAjc2l6ZS1jZWxscyA9ICZsdDsweDEmZ3Q7
Ozxicj4KoKCgoKCgoKAjYWRkcmVzcy1jZWxscyA9ICZsdDsweDEmZ3Q7Ozxicj4KPGJyPgqgoKCg
oKCgoGFsaWFzZXMgezxicj4KoKCgoKCgoKCgoKCgoKCgoGV0aGVybmV0MAo9ICZhbXA7ZW5ldDA7
PGJyPgqgoKCgoKCgoKCgoKCgoKCgZXRoZXJuZXQxCj0gJmFtcDtlbmV0MTs8YnI+CqCgoKCgoKCg
oKCgoKCgoKBzZXJpYWwwCj0gJmFtcDtzZXJpYWwwOzxicj4KoKCgoKCgoKCgoKCgoKCgoHNlcmlh
bDEKPSAmYW1wO3NlcmlhbDE7PGJyPgqgoKCgoKCgoKCgoKCgoKCgcGNpMAo9ICZhbXA7cGNpMDs8
YnI+CqCgoKCgoKCgoKCgoKCgoKBwY2kxCj0gJmFtcDtwY2kxOzxicj4KoKCgoKCgoKB9Ozxicj4K
oKCgoKCgoKAgY3B1cyB7PGJyPgqgoKCgoKCgoKCgoKCgoKCgbGludXgscGhhbmRsZQo9ICZsdDsw
eDIwMCZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgI2NwdXMKPSAmbHQ7MHgxJmd0Ozs8YnI+CqCg
oKCgoKCgoKCgoKCgoKAjYWRkcmVzcy1jZWxscwo9ICZsdDsxJmd0Ozs8YnI+CqCgoKCgoKCgoKCg
oKCgoKAjc2l6ZS1jZWxscwo9ICZsdDswJmd0Ozs8YnI+Cjxicj4KoKBQb3dlclBDLDgzNDNFQUAw
IHs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZGV2aWNlX3R5cGUKPSAmcXVvdDtjcHUmcXVv
dDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKByZWcKPSAmbHQ7MHgwJmd0Ozs8YnI+CqCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoGQtY2FjaGUtbGluZS1zaXplCj0gJmx0OzIwJmd0Ozs8YnI+
CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGktY2FjaGUtbGluZS1zaXplCj0gJmx0OzIwJmd0Ozs8
YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGQtY2FjaGUtc2l6ZQo9ICZsdDs4MDAwJmd0Ozs8
YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGktY2FjaGUtc2l6ZQo9ICZsdDs4MDAwJmd0Ozs8
YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHRpbWViYXNlLWZyZXF1ZW5jeQo9ICZsdDswJmd0
OzugoKCgoKAgLy8gZnJvbSBib290bG9hZGVyPGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBi
dXMtZnJlcXVlbmN5Cj0KJmx0OzAmZ3Q7O6CgoKCgoKCgoKCgoC8vCmZyb20gYm9vdGxvYWRlcjxi
cj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgY2xvY2stZnJlcXVlbmN5Cj0gJmx0OzAmZ3Q7O6Cg
oKCgoKCgoKAvLyBmcm9tCmJvb3Rsb2FkZXI8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoDMy
LWJpdDs8YnI+CqCgoKCgoKCgoKCgoKCgoKB9Ozxicj4KoKCgoKCgoKB9Ozxicj4KPGJyPgo8YnI+
CqCgoKCgoKCgbWVtb3J5IHs8YnI+CqCgoKCgoKCgoKCgoKCgoKBkZXZpY2VfdHlwZQo9ICZxdW90
O21lbW9yeSZxdW90Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKByZWcKPSAmbHQ7MHgwMDAwMDAwMCAw
eDEwMDAwMDAwJmd0OzugoC8vIDI1Nk1CIGF0IDA8YnI+CqCgoKCgoKCgfTs8YnI+Cjxicj4KoKCg
oKCgoKBiY3NyQGUyNDAwMDAwIHs8YnI+CqCgoKCgoKCgoKCgoKCgoKBkZXZpY2VfdHlwZQo9ICZx
dW90O2JvYXJkLWNvbnRyb2wmcXVvdDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgcmVnCj0gJmx0OzB4
ZTI0MDAwMDAgMHg4MDAwJmd0Ozs8YnI+CqCgoKCgoKCgfTs8YnI+CqCgoKCgoKCgc29jODM0M0Bl
MDAwMDAwMCB7PGJyPgqgoKCgoKCgoKCgoKCgoKCgYnVzLWZyZXF1ZW5jeQo9ICZsdDsweDEmZ3Q7
Ozxicj4KoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZsdDsweGUwMDAwMDAwIDB4MjAwJmd0Ozs8YnI+
CqCgoKCgoKCgoKCgoKCgoKByYW5nZXMKPSAmbHQ7MHgwIDB4ZTAwMDAwMDAgMHgxMDAwMDAmZ3Q7
Ozxicj4KoKCgoKCgoKCgoKCgoKCgoGRldmljZV90eXBlCj0gJnF1b3Q7c29jJnF1b3Q7Ozxicj4K
oKCgoKCgoKCgoKCgoKCgoCNpbnRlcnJ1cHQtY2VsbHMKPSAmbHQ7MHgyJmd0Ozs8YnI+CqCgoKCg
oKCgoKCgoKCgoKAjc2l6ZS1jZWxscwo9ICZsdDsweDEmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCg
oCNhZGRyZXNzLWNlbGxzCj0gJmx0OzB4MSZndDs7PGJyPgo8YnI+CqCgoKCgoKCgoKCgoKCgoKB3
ZHRAMjAwCns8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGRldmljZV90eXBlCj0gJnF1b3Q7
d2F0Y2hkb2cmcXVvdDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjb21wYXRpYmxlCj0g
JnF1b3Q7bXBjODN4eF93ZHQmcXVvdDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKByZWcK
PSAmbHQ7MHgyMDAgMHgxMDAmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoH07PGJyPgo8YnI+Cmky
Y0AzMDAwIHs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCNhZGRyZXNzLWNlbGxzCj0gJmx0
OzEmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgI3NpemUtY2VsbHMKPSAmbHQ7MCZn
dDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjZWxsLWluZGV4Cj0gJmx0OzAmZ3Q7Ozxi
cj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgY29tcGF0aWJsZQo9ICZxdW90O2ZzbC1pMmMmcXVv
dDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKByZWcKPSAmbHQ7MHgzMDAwIDB4MTAwJmd0
Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdHMKPSAmbHQ7MTQgMHg4Jmd0
Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdC1wYXJlbnQKPSAmbHQ7JmFt
cDtpcGljJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGRmc3JyOzxicj4KPGJyPgqg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBydGNANjgKezxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKBjb21wYXRpYmxlCj0gJnF1b3Q7ZGFsbGFzLGRzMTM3NCZxdW90Ozs8YnI+CqCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcmVnCj0gJmx0OzB4NjgmZ3Q7Ozxicj4KoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgfTs8YnI+CqCgoKCgoKCgoKCgoKCgoKB9Ozxicj4KPGJyPgqg
oKCgoKCgoKCgoKCgoKCgaTJjQDMxMDAKezxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgI2Fk
ZHJlc3MtY2VsbHMKPSAmbHQ7MSZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAjc2l6
ZS1jZWxscwo9ICZsdDswJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNlbGwtaW5k
ZXgKPSAmbHQ7MSZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjb21wYXRpYmxlCj0g
JnF1b3Q7ZnNsLWkyYyZxdW90Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZs
dDsweDMxMDAgMHgxMDAmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgaW50ZXJydXB0
cwo9ICZsdDsxNSAweDgmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgaW50ZXJydXB0
LXBhcmVudAo9ICZsdDsmYW1wO2lwaWMmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
ZGZzcnI7PGJyPgqgoKCgoKCgoKCgoKCgoKCgfTs8YnI+Cjxicj4KoKCgoKCgoKCgoKCgoKCgoHNw
aUA3MDAwCns8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNlbGwtaW5kZXgKPSAmbHQ7MCZn
dDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjb21wYXRpYmxlCj0gJnF1b3Q7ZnNsLHNw
aSZxdW90Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZsdDsweDcwMDAgMHgx
MDAwJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdHMKPSAmbHQ7MTYg
MHg4Jmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdC1wYXJlbnQKPSAm
bHQ7JmFtcDtpcGljJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoG1vZGUKPSAmcXVv
dDtjcHUmcXVvdDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgfTs8YnI+Cjxicj4KZG1hQDgyYTggezxi
cj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgI2FkZHJlc3MtY2VsbHMKPSAmbHQ7MSZndDs7PGJy
PgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAjc2l6ZS1jZWxscwo9ICZsdDsxJmd0Ozs8YnI+CqCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNvbXBhdGlibGUKPSAmcXVvdDtmc2wsbXBjODM0OS1kbWEm
cXVvdDssICZxdW90O2ZzbCxlbG8tZG1hJnF1b3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgcmVnCj0gJmx0OzB4ODJhOCA0Jmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJh
bmdlcwo9ICZsdDswIDB4ODEwMCAweDFhOCZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKBpbnRlcnJ1cHQtcGFyZW50Cj0gJmx0OyZhbXA7aXBpYyZndDs7PGJyPgqgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKBpbnRlcnJ1cHRzCj0gJmx0OzcxIDgmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgY2VsbC1pbmRleAo9ICZsdDswJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoGRtYS1jaGFubmVsQDAKezxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBj
b21wYXRpYmxlCj0gJnF1b3Q7ZnNsLG1wYzgzNDktZG1hLWNoYW5uZWwmcXVvdDssICZxdW90O2Zz
bCxlbG8tZG1hLWNoYW5uZWwmcXVvdDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoHJlZwo9ICZsdDswIDB4ODAmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKBpbnRlcnJ1cHQtcGFyZW50Cj0gJmx0OyZhbXA7aXBpYyZndDs7PGJyPgqgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdHMKPSAmbHQ7NzEgOCZndDs7PGJyPgqgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKB9Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZG1hLWNo
YW5uZWxAODAKezxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjb21wYXRpYmxl
Cj0gJnF1b3Q7ZnNsLG1wYzgzNDktZG1hLWNoYW5uZWwmcXVvdDssICZxdW90O2ZzbCxlbG8tZG1h
LWNoYW5uZWwmcXVvdDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9
ICZsdDsweDgwIDB4ODAmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBp
bnRlcnJ1cHQtcGFyZW50Cj0gJmx0OyZhbXA7aXBpYyZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoGludGVycnVwdHMKPSAmbHQ7NzEgOCZndDs7PGJyPgqgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKB9Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZG1hLWNoYW5uZWxA
MTAwCns8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgY29tcGF0aWJsZQo9ICZx
dW90O2ZzbCxtcGM4MzQ5LWRtYS1jaGFubmVsJnF1b3Q7LCAmcXVvdDtmc2wsZWxvLWRtYS1jaGFu
bmVsJnF1b3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKByZWcKPSAmbHQ7
MHgxMDAgMHg4MCZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVy
cnVwdC1wYXJlbnQKPSAmbHQ7JmFtcDtpcGljJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgaW50ZXJydXB0cwo9ICZsdDs3MSA4Jmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoH07PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBkbWEtY2hhbm5lbEAxODAK
ezxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjb21wYXRpYmxlCj0gJnF1b3Q7
ZnNsLG1wYzgzNDktZG1hLWNoYW5uZWwmcXVvdDssICZxdW90O2ZzbCxlbG8tZG1hLWNoYW5uZWwm
cXVvdDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZsdDsweDE4
MCAweDI4Jmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgaW50ZXJydXB0
LXBhcmVudAo9ICZsdDsmYW1wO2lwaWMmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKBpbnRlcnJ1cHRzCj0gJmx0OzcxIDgmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgfTs8YnI+CqCgoKCgoKCgoKCgoKCgoKB9Ozxicj4KLyogcGh5IHR5cGUgKFVMUEkgb3Ig
U0VSSUFMKSBhcmUgb25seSB0eXBlcyBzdXBwb3J0ZWQgZm9yIE1QSCAqLzxicj4KoKCgoKCgoKCg
oKCgoKCgoC8qCnBvcnQgPSAwIG9yIDEgKi88YnI+CqCgoKCgoKCgoKCgoKCgoKB1c2JAMjIwMDAK
ezxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgY29tcGF0aWJsZQo9ICZxdW90O2ZzbC11c2Iy
LW1waCZxdW90Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZsdDsweDIyMDAw
IDB4MTAwMCZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAjYWRkcmVzcy1jZWxscwo9
ICZsdDsxJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCNzaXplLWNlbGxzCj0gJmx0
OzAmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgaW50ZXJydXB0LXBhcmVudAo9ICZs
dDsmYW1wO2lwaWMmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgaW50ZXJydXB0cwo9
ICZsdDszOSAweDgmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcGh5X3R5cGUKPSAm
cXVvdDt1bHBpJnF1b3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcG9ydDE7PGJyPgqg
oKCgoKCgoKCgoKCgoKCgfTs8YnI+CqCgoKCgoKCgoKCgoKCgoKAvKgpwaHkgdHlwZSAoVUxQSSwg
VVRNSSwgVVRNSV9XSURFLCBTRVJJQUwpICovPGJyPgqgoKCgoKCgoKCgoKCgoKCgdXNiQDIzMDAw
Cns8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNvbXBhdGlibGUKPSAmcXVvdDtmc2wtdXNi
Mi1kciZxdW90Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZsdDsweDIzMDAw
IDB4MTAwMCZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAjYWRkcmVzcy1jZWxscwo9
ICZsdDsxJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCNzaXplLWNlbGxzCj0gJmx0
OzAmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgaW50ZXJydXB0LXBhcmVudAo9ICZs
dDsmYW1wO2lwaWMmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgaW50ZXJydXB0cwo9
ICZsdDszOCAweDgmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZHJfbW9kZQo9ICZx
dW90O290ZyZxdW90Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHBoeV90eXBlCj0gJnF1
b3Q7dWxwaSZxdW90Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKB9Ozxicj4KPGJyPgqgoKCgoKCgoKCg
oKCgoKCgbWRpb0AyNDUyMAp7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAjYWRkcmVzcy1j
ZWxscwo9ICZsdDsxJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCNzaXplLWNlbGxz
Cj0gJmx0OzAmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgY29tcGF0aWJsZQo9ICZx
dW90O2ZzbCxnaWFuZmFyLW1kaW8mcXVvdDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBy
ZWcKPSAmbHQ7MHgyNDUyMCAweDIwJmd0Ozs8YnI+Cjxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgcGh5MDoKZXRoZXJuZXQtcGh5QDAgezxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKBpbnRlcnJ1cHQtcGFyZW50Cj0gJmx0OyZhbXA7aXBpYyZndDs7PGJyPgqgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdHMKPSAmbHQ7MTcgMHg4Jmd0Ozs8YnI+CqCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcmVnCj0gJmx0OzB4MCZndDs7PGJyPgqgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGRldmljZV90eXBlCj0gJnF1b3Q7ZXRoZXJuZXQt
cGh5JnF1b3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgfTs8YnI+CqCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoHBoeTE6CmV0aGVybmV0LXBoeUAxIHs8YnI+CqCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgaW50ZXJydXB0LXBhcmVudAo9ICZsdDsmYW1wO2lwaWMmZ3Q7Ozxicj4K
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBpbnRlcnJ1cHRzCj0gJmx0OzE4IDB4OCZn
dDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZsdDsweDEmZ3Q7
Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBkZXZpY2VfdHlwZQo9ICZxdW90
O2V0aGVybmV0LXBoeSZxdW90Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoH07PGJyPgpl
bmV0MDogZXRoZXJuZXRAMjQwMDAgezxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgY2VsbC1p
bmRleAo9ICZsdDswJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGRldmljZV90eXBl
Cj0gJnF1b3Q7bmV0d29yayZxdW90Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoG1vZGVs
Cj0gJnF1b3Q7VFNFQyZxdW90Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNvbXBhdGli
bGUKPSAmcXVvdDtnaWFuZmFyJnF1b3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcmVn
Cj0gJmx0OzB4MjQwMDAgMHgxMDAwJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGxv
Y2FsLW1hYy1hZGRyZXNzCj0gWyAwMCAwMCAwMCAwMCAwMCAwMCBdOzxicj4KoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgaW50ZXJydXB0cwo9ICZsdDszMiAweDggMzMgMHg4IDM0IDB4OCZndDs7PGJy
PgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBpbnRlcnJ1cHQtcGFyZW50Cj0gJmx0OyZhbXA7aXBp
YyZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBwaHktaGFuZGxlCj0gJmx0OyZhbXA7
cGh5MCZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBsaW51eCxuZXR3b3JrLWluZGV4
Cj0gJmx0OzAmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoH07PGJyPgo8YnI+CqCgoKCgoKCgoKCg
oKCgoKBlbmV0MToKZXRoZXJuZXRAMjUwMDAgezxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
Y2VsbC1pbmRleAo9ICZsdDsxJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGRldmlj
ZV90eXBlCj0gJnF1b3Q7bmV0d29yayZxdW90Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oG1vZGVsCj0gJnF1b3Q7VFNFQyZxdW90Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNv
bXBhdGlibGUKPSAmcXVvdDtnaWFuZmFyJnF1b3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgcmVnCj0gJmx0OzB4MjUwMDAgMHgxMDAwJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoGxvY2FsLW1hYy1hZGRyZXNzCj0gWyAwMCAwMCAwMCAwMCAwMCAwMCBdOzxicj4KoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgaW50ZXJydXB0cwo9ICZsdDszNSAweDggMzYgMHg4IDM3IDB4OCZn
dDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBpbnRlcnJ1cHQtcGFyZW50Cj0gJmx0OyZh
bXA7aXBpYyZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBwaHktaGFuZGxlCj0gJmx0
OyZhbXA7cGh5MSZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBsaW51eCxuZXR3b3Jr
LWluZGV4Cj0gJmx0OzEmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoH07PGJyPgo8YnI+CnNlcmlh
bDA6IHNlcmlhbEA0NTAwIHs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNlbGwtaW5kZXgK
PSAmbHQ7MCZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBkZXZpY2VfdHlwZQo9ICZx
dW90O3NlcmlhbCZxdW90Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNvbXBhdGlibGUK
PSAmcXVvdDtuczE2NTUwJnF1b3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcmVnCj0g
Jmx0OzB4NDUwMCAweDEwMCZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjbG9jay1m
cmVxdWVuY3kKPSAmbHQ7MCZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBpbnRlcnJ1
cHRzCj0gJmx0OzkgMHg4Jmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVw
dC1wYXJlbnQKPSAmbHQ7JmFtcDtpcGljJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKB9Ozxicj4K
PGJyPgqgoKCgoKCgoKCgoKCgoKCgc2VyaWFsMToKc2VyaWFsQDQ2MDAgezxicj4KoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgY2VsbC1pbmRleAo9ICZsdDsxJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoGRldmljZV90eXBlCj0gJnF1b3Q7c2VyaWFsJnF1b3Q7Ozxicj4KoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgY29tcGF0aWJsZQo9ICZxdW90O25zMTY1NTAmcXVvdDs7PGJyPgqgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKByZWcKPSAmbHQ7MHg0NjAwIDB4MTAwJmd0Ozs8YnI+CqCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoGNsb2NrLWZyZXF1ZW5jeQo9ICZsdDswJmd0Ozs8YnI+CqCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdHMKPSAmbHQ7MTAgMHg4Jmd0Ozs8YnI+CqCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdC1wYXJlbnQKPSAmbHQ7JmFtcDtpcGljJmd0Ozs8
YnI+CqCgoKCgoKCgoKCgoKCgoKB9Ozxicj4KPGJyPgqgoKCgoKCgoKCgoKCgoKCgY3J5cHRvQDMw
MDAwCns8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNvbXBhdGlibGUKPSAmcXVvdDtmc2ws
c2VjMi4wJnF1b3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcmVnCj0gJmx0OzB4MzAw
MDAgMHgxMDAwMCZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBpbnRlcnJ1cHRzCj0g
Jmx0OzExIDB4OCZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBpbnRlcnJ1cHQtcGFy
ZW50Cj0gJmx0OyZhbXA7aXBpYyZndDs7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBmc2ws
bnVtLWNoYW5uZWxzCj0gJmx0OzQmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZnNs
LGNoYW5uZWwtZmlmby1sZW4KPSAmbHQ7MjQmZ3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgZnNsLGV4ZWMtdW5pdHMtbWFzawo9ICZsdDsweDdlJmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoGZzbCxkZXNjcmlwdG9yLXR5cGVzLW1hc2sKPSAmbHQ7MHgwMTAxMGViZiZndDs7
PGJyPgqgoKCgoKCgoKCgoKCgoKCgfTs8YnI+Cjxicj4KVGhhbmtzLDxicj4KYWduZWw8YnI+Cjxi
cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+Ckxp
bnV4cHBjLWRldiBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpMaW51eHBwYy1kZXZA
bGlzdHMub3psYWJzLm9yZyIgdGFyZ2V0PSJfYmxhbmsiIG9uY2xpY2s9InJldHVybiB0b3AuanMu
T3BlbkV4dExpbmsod2luZG93LGV2ZW50LHRoaXMpIj5MaW51eHBwYy1kZXZAbGlzdHMub3psYWJz
Lm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9s
aW51eHBwYy1kZXYiIHRhcmdldD0iX2JsYW5rIiBvbmNsaWNrPSJyZXR1cm4gdG9wLmpzLk9wZW5F
eHRMaW5rKHdpbmRvdyxldmVudCx0aGlzKSI+aHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3Rp
bmZvL2xpbnV4cHBjLWRldjwvYT48L3A+Cgo8L2Rpdj4KCjxwIGNsYXNzPSJNc29Ob3JtYWwiPqA8
L3A+Cgo8L3NwYW4+PC9kaXY+PC9kaXY+Cgo8L2Rpdj4KCgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJy
Pgo=
--001636e0ae11dac6d7047a52eceb--
