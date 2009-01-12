Return-Path: <florian.belser@freenet.de>
Received: from mout3.freenet.de (mout3.freenet.de [195.4.92.93])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 03D0CDE02A
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 20:24:16 +1100 (EST)
Received: from [195.4.92.24] (helo=14.mx.freenet.de)
	by mout3.freenet.de with esmtpa (ID florian.belser@freenet.de) (port
	25) (Exim 4.69 #76) id 1LMIlS-0006TI-CP
	for linuxppc-dev@ozlabs.org; Mon, 12 Jan 2009 10:07:18 +0100
Received: from web8.emo.freenet-rz.de ([194.97.107.224]:34803)
	by 14.mx.freenet.de with esmtpa (ID florian.belser@freenet.de) (port
	25) (Exim 4.69 #76) id 1LMIlS-0001Pf-Ba
	for linuxppc-dev@ozlabs.org; Mon, 12 Jan 2009 10:07:18 +0100
Received: from localhost ([127.0.0.1] helo=emo.freenet.de)
	by web8.emo.freenet-rz.de with esmtpa (Exim 4.67 1 (Panther_1))
	id 1LMIlR-0003C7-By
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 10:07:17 +0100
Date: Mon, 12 Jan 2009 10:07:17 +0100
From: florian.belser@freenet.de
Subject: mpc5200b configure nand driver via dts
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Message-Id: <c4fbc703368c62be70c700e6f962eb12@email.freenet.de>
Content-Type: multipart/alternative;
	boundary="emo_01_56774754eadcab12727ae40bf1c3073e"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--emo_01_56774754eadcab12727ae40bf1c3073e
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

hello,=0AI have some problems with an mpc5200b based board. It\'s nearly
compatible to the lite5200b board.=0AI connected an samsung k9k8g08u0a
nand flash via the lpb bus. This works fine with an self written nand
driver. =0ANow I try to use the standard nand driver from linux and
configure it via the dts file. But this doesn\'t work and I get =0Athe
following output:=0Afc000000.flash: Found 1 x16 devices at 0x0 in 16-bit
bank=0A Amd/Fujitsu Extended Query Table at 0x0040=0AUsing buffer write
method=0Afc000000.flash: CFI does not contain boot bank location. Assuming
top.=0Anumber of CFI chips: 1=0Acfi_cmdset_0002: Disabling
erase-suspend-program due to code brokenness.=0Acmdlinepart partition
parsing not available=0ARedBoot partition parsing not available=0ACreating =
5
MTD partitions on \"fc000000.flash\":=0A0x00000000-0x03d00000 :
\"fs\"=0Amtd: Giving out device 0 to fs=0A0x03d00000-0x03f00000 :
\"kernel\"=0Amtd: Giving out device 1 to kernel=0A0x03f00000-0x03f40000 :
\"u-boot\"=0Amtd: Giving out device 2 to u-boot=0A0x03f40000-0x03f60000 :
\"u-boot-env\"=0Amtd: Giving out device 3 to
u-boot-env=0A0x03f60000-0x04000000 : \"fdt\"=0Amtd: Giving out device 4 to
fdt=0A------------[ cut here ]------------=0Akernel BUG at
arch/powerpc/mm/pgtable_32.c:283!=0AOops: Exception in kernel mode, sig: 5
[#1]=0Alite5200=0AModules linked in:=0ANIP: c00132f8 LR: c00134c4 CTR:
00000000=0AREGS: c7827c60 TRAP: 0700   Not tainted  (2.6.28-rc6)=0AMSR:
00029032 <EE,ME,IR,DR>  CR: 82000022  XER: 20000000=0ATASK =3D c7828000[1]
\'swapper\' THREAD: c7826000=0AGPR00: f00085a9 c7827d10 c7828000 00000000
70000000 000005a9 fdff8000 c03d123c=0AGPR08: c7810d00 00000001 c78a0000
c9000000 00000000 ffffffff 07fbf000 07fb4e04=0AGPR16: 07faff18 07fb4e28
07f559f4 07f558f4 07f55844 00000001 07f557b0 07f5583b=0AGPR24: 00000000
c03d0000 70000000 000005a9 70000000 c9000000 c039e000 00000c90=0ANIP
[c00132f8] map_page+0x50/0xa8=0ALR [c00134c4] __ioremap+0xd0/0x158=0ACall
Trace:=0A[c7827d10] [c03d0000] 0xc03d0000 (unreliable)=0A[c7827d30]
[c00134c4] __ioremap+0xd0/0x158=0A[c7827d60] [c02ce1ec]
of_flash_probe+0xd0/0x4cc=0A[c7827db0] [c0209d38]
of_platform_device_probe+0x5c/0x84=0A[c7827dd0] [c0192df4]
driver_probe_device+0xb8/0x1e8=0A[c7827df0] [c0192fc8]
__driver_attach+0xa4/0xa8=0A[c7827e10] [c01922f8]
bus_for_each_dev+0x5c/0x98=0A[c7827e40] [c0192bfc]
driver_attach+0x24/0x34=0A[c7827e50] [c0192948]
bus_add_driver+0x1d8/0x258=0A[c7827e80] [c01931d8]
driver_register+0x5c/0x158=0A[c7827ea0] [c0209c00]
of_register_driver+0x54/0x70=0A[c7827eb0] [c038a5f4]
of_flash_init+0x20/0x30=0A[c7827ec0] [c00038e8]
do_one_initcall+0x38/0x1a4=0A[c7827fd0] [c0375168]
kernel_init+0x88/0xf4=0A[c7827ff0] [c0010a8c]
kernel_thread+0x4c/0x68=0AInstruction dump:=0A7cbb2b78 83c9f40c 7c1ff02e
7c7ff214 54090027 41820050 3d29c000 57a3b53a=0A7d491a15 4182005c 7c09182e
540907be <0f090000> 578b0026 540007bc 7f6b5b78=0A---[ end trace
4a998b56addb143e ]---=0AKernel panic - not syncing: Attempted to kill
init!=0ARebooting in 1 seconds..=0Adts lpb configuration:=0Alpb {=0A      =
=20
model =3D\"fsl,lpb\";=0A  compatible =3D \"fsl,lpb\",\"simple-bus\";=0A    =
  =20
device_type =3D \"lpb\";=0A        #size-cells =3D <1>;=0A    #address-cell=
s =3D
<2>;=0A        ranges =3D <0x0 0x0 0xfc000000 0x04000000=0A  0x1 0x0
0x70000000 0x00000100>;=0A  flash@0,0{  // cs0=0A            compatible =3D
\"cfi-flash\";=0A   #size-cells =3D <1>;=0A            #address-cells =3D <=
1>;=0A=20
          bank-width =3D <2>;=0A            reg =3D <0x0 0x0 0x04000000>;=
=0A   =20
       partition@0 {=0A    label =3D \"fs\";=0A    reg =3D <0x00000000
0x03d00000>;=0A            };=0A            partition@3d000000 {=0A    labe=
l =3D
\"kernel\";=0A    reg =3D <0x03d00000 0x200000>;=0A            };=0A       =
   =20
partition@3df00000 {=0A                label =3D \"u-boot\";=0A            =
  =20
reg =3D <0x03f00000 0x40000>;=0A            };=0A            partition@3f40=
000
{=0A                label =3D \"u-boot-env\";=0A                reg=3D
<0x03f40000 0x20000>;=0A            };=0A            partition@3f60000 {=0A=
  =20
            label =3D \"fdt\";=0A                reg=3D <0x03f60000 0xa0000=
>;=0A
           };=0A        };=0A  nand@1,0 {  //cs1=0A   compatible =3D \"sams=
ung,
k9k8g08u08\", \"cfi-flash\";=0A   #size-cells =3D <1>;=0A       =20
#address-cells =3D <1>;=0A   bank-width =3D <1>;=0A   reg =3D <0x1 0x0
0x40000000>;=0A   partition@0 {=0A    label =3D \"nand-flash\";=0A    reg =
=3D
<0x00000000 0x40000000>;=0A   };=0A  };=0A};=0ANow my questions are:=0A Is =
there
any error in the dts configuration?=0A Is it principle posible to
configure a nand flash via the dts file (in combination with mpc5200b)?=0A
I read in some forums that the nand flash must be activated in the
u-boot before it can be configured via dts. =0A This makes no sense for
me, but maybe it\'s true?=0AI hope you can help me with my problem and if
i made some style errors for the post, I say sorry.=0AThanks a lot.=0Abest
regards=0Aflorian belser=0A=0AGratis: Jeden Monat 3 SMS versenden-=0AMit
freenetMail - Ihrer kostenlose
E-Mail-Adresse=0Ahttp://email.freenet.de/dienste/emailoffice/produktuebersi=
cht/basic/sms/index.html?pid=3D6830=0A

--emo_01_56774754eadcab12727ae40bf1c3073e
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0
Transitional//DE"><HTML><HEAD><META HTTP-EQUIV=3D"Content-Type"
CONTENT=3D"text/html;
charset=3Dus-ascii"><TITLE>Message</TITLE></HEAD><BODY><P>hello,</P>
<P>I have some problems with an mpc5200b based board. It's nearly
compatible to the lite5200b board.<BR>I connected an samsung k9k8g08u0a
nand flash via the lpb bus. This works fine with an self written nand
driver. <BR>Now I try to use the standard nand driver from linux and
configure it via the dts file. But this doesn't work and I get <BR>the
following output:</P>
<P>fc000000.flash: Found 1 x16 devices at 0x0 in 16-bit
bank<BR>&nbsp;Amd/Fujitsu Extended Query Table at 0x0040<BR>Using buffer
write method<BR>fc000000.flash: CFI does not contain boot bank location.
Assuming top.<BR>number of CFI chips: 1<BR>cfi_cmdset_0002: Disabling
erase-suspend-program due to code brokenness.<BR>cmdlinepart partition
parsing not available<BR>RedBoot partition parsing not
available<BR>Creating 5 MTD partitions on
"fc000000.flash":<BR>0x00000000-0x03d00000 : "fs"<BR>mtd: Giving out
device 0 to fs<BR>0x03d00000-0x03f00000 : "kernel"<BR>mtd: Giving out
device 1 to kernel<BR>0x03f00000-0x03f40000 : "u-boot"<BR>mtd: Giving
out device 2 to u-boot<BR>0x03f40000-0x03f60000 : "u-boot-env"<BR>mtd:
Giving out device 3 to u-boot-env<BR>0x03f60000-0x04000000 :
"fdt"<BR>mtd: Giving out device 4 to fdt<BR>------------[ cut here
]------------<BR>kernel BUG at
arch/powerpc/mm/pgtable_32.c:283!<BR>Oops: Exception in kernel mode,
sig: 5 [#1]<BR>lite5200<BR>Modules linked in:<BR>NIP: c00132f8 LR:
c00134c4 CTR: 00000000<BR>REGS: c7827c60 TRAP: 0700&nbsp;&nbsp; Not
tainted&nbsp; (2.6.28-rc6)<BR>MSR: 00029032 &lt;EE,ME,IR,DR&gt;&nbsp;
CR: 82000022&nbsp; XER: 20000000<BR>TASK =3D c7828000[1] 'swapper' THREAD:
c7826000<BR>GPR00: f00085a9 c7827d10 c7828000 00000000 70000000 000005a9
fdff8000 c03d123c<BR>GPR08: c7810d00 00000001 c78a0000 c9000000 00000000
ffffffff 07fbf000 07fb4e04<BR>GPR16: 07faff18 07fb4e28 07f559f4 07f558f4
07f55844 00000001 07f557b0 07f5583b<BR>GPR24: 00000000 c03d0000 70000000
000005a9 70000000 c9000000 c039e000 00000c90<BR>NIP [c00132f8]
map_page+0x50/0xa8<BR>LR [c00134c4] __ioremap+0xd0/0x158<BR>Call
Trace:<BR>[c7827d10] [c03d0000] 0xc03d0000 (unreliable)<BR>[c7827d30]
[c00134c4] __ioremap+0xd0/0x158<BR>[c7827d60] [c02ce1ec]
of_flash_probe+0xd0/0x4cc<BR>[c7827db0] [c0209d38]
of_platform_device_probe+0x5c/0x84<BR>[c7827dd0] [c0192df4]
driver_probe_device+0xb8/0x1e8<BR>[c7827df0] [c0192fc8]
__driver_attach+0xa4/0xa8<BR>[c7827e10] [c01922f8]
bus_for_each_dev+0x5c/0x98<BR>[c7827e40] [c0192bfc]
driver_attach+0x24/0x34<BR>[c7827e50] [c0192948]
bus_add_driver+0x1d8/0x258<BR>[c7827e80] [c01931d8]
driver_register+0x5c/0x158<BR>[c7827ea0] [c0209c00]
of_register_driver+0x54/0x70<BR>[c7827eb0] [c038a5f4]
of_flash_init+0x20/0x30<BR>[c7827ec0] [c00038e8]
do_one_initcall+0x38/0x1a4<BR>[c7827fd0] [c0375168]
kernel_init+0x88/0xf4<BR>[c7827ff0] [c0010a8c]
kernel_thread+0x4c/0x68<BR>Instruction dump:<BR>7cbb2b78 83c9f40c
7c1ff02e 7c7ff214 54090027 41820050 3d29c000 57a3b53a<BR>7d491a15
4182005c 7c09182e 540907be &lt;0f090000&gt; 578b0026 540007bc
7f6b5b78<BR>---[ end trace 4a998b56addb143e ]---<BR>Kernel panic - not
syncing: Attempted to kill init!<BR>Rebooting in 1 seconds..</P>
<P>dts lpb configuration:</P>
<P>lpb {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; model
=3D"fsl,lpb";<BR>&nbsp;&nbsp;compatible =3D
"fsl,lpb","simple-bus";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
device_type =3D "lpb";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
#size-cells =3D &lt;1&gt;;<BR>&nbsp; &nbsp;&nbsp;#address-cells =3D
&lt;2&gt;;</P>
<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges =3D &lt;0x0 0x0
0xfc000000 0x04000000<BR>&nbsp;&nbsp;0x1 0x0 0x70000000
0x00000100&gt;;</P>
<P>&nbsp;&nbsp;<A href=3D"mailto:flash@0,0">flash@0,0</A>{&nbsp; //
cs0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
compatible =3D "cfi-flash";<BR>&nbsp;&nbsp;&nbsp;#size-cells =3D
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
#address-cells =3D
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
bank-width =3D
&lt;2&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
reg =3D &lt;0x0 0x0
0x04000000&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
<A href=3D"mailto:partition@0">partition@0</A>
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;label =3D
"fs";<BR>&nbsp;&nbsp;&nbsp;&nbsp;reg =3D &lt;0x00000000
0x03d00000&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<A href=3D"mailto:partition@3d000000">partition@3d000000</A>
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;label =3D
"kernel";<BR>&nbsp;&nbsp;&nbsp;&nbsp;reg =3D &lt;0x03d00000
0x200000&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<A href=3D"mailto:partition@3df00000">partition@3df00000</A>
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
label =3D
"u-boot";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
reg =3D &lt;0x03f00000
0x40000&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<A href=3D"mailto:partition@3f40000">partition@3f40000</A>
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
label =3D
"u-boot-env";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
reg=3D &lt;0x03f40000
0x20000&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<A href=3D"mailto:partition@3f60000">partition@3f60000</A>
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
label =3D
"fdt";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
reg=3D &lt;0x03f60000
0xa0000&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>&nbsp;&nbsp;<A
href=3D"mailto:nand@1,0">nand@1,0</A> {&nbsp;
//cs1<BR>&nbsp;&nbsp;&nbsp;compatible =3D "samsung, k9k8g08u08",
"cfi-flash";<BR>&nbsp;&nbsp;&nbsp;#size-cells =3D
&lt;1&gt;;<BR>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells
=3D &lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;bank-width =3D
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;reg =3D &lt;0x1 0x0
0x40000000&gt;;<BR>&nbsp;&nbsp;&nbsp;<A
href=3D"mailto:partition@0">partition@0</A>
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;label =3D
"nand-flash";<BR>&nbsp;&nbsp;&nbsp;&nbsp;reg =3D &lt;0x00000000
0x40000000&gt;;<BR>&nbsp;&nbsp;&nbsp;};<BR>&nbsp;&nbsp;};<BR>};</P>
<P>Now my questions are:<BR>&nbsp;Is there any error in the dts
configuration?<BR>&nbsp;Is it principle posible to configure a nand
flash via the dts file (in combination with mpc5200b)?<BR>&nbsp;I read
in some forums that the nand flash must be activated in the u-boot
before it can be configured via dts. <BR>&nbsp;This makes no sense for
me, but maybe it's true?</P>
<P>I hope you can help me with my problem and if i made some style
errors for the post, I say sorry.<BR>Thanks a lot.</P>
<P>best regards</P>
<P>florian belser</P>=0A=0A=0A<br>--<br><!-- AdSpace freenet EMO Webmail
Banner --> =0A<a
href=3D"http://adserver.freenet.de/click.ng/site=3Dfn&prod=3Dchetools&kat=
=3Dinhalte&tbl=3Dwebmail&ppos=3D14&TransactionID=3D1231751237342010&rgtg=3D=
256"
target=3D"_blank"><img
src=3D"http://adserver.freenet.de/image.ng/site=3Dfn&prod=3Dchetools&kat=3D=
inhalte&tbl=3Dwebmail&ppos=3D14&TransactionID=3D1231751237342010&rgtg=3D256=
"
border=3D"0"></a><!-- / AdSpace -->=0A</BODY></HTML>

--emo_01_56774754eadcab12727ae40bf1c3073e--
