Return-Path: <YGoldberger@nds.com>
Received: from ilsmtp.nds.com (ilsmtp.nds.com [192.118.32.12])
	by ozlabs.org (Postfix) with ESMTP id 6673BDDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 04:12:45 +1100 (EST)
From: "Goldberger, Yigal" <YGoldberger@nds.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Wed, 25 Mar 2009 19:06:50 +0200
Subject: ELDK with Xenomai for PPC
Message-ID: <7913DB5FA7D3F643A2C10A4A8E2DFAF43A3A5D7C25@ILMA1.IL.NDS.COM>
Content-Type: multipart/alternative;
	boundary="_000_7913DB5FA7D3F643A2C10A4A8E2DFAF43A3A5D7C25ILMA1ILNDSCOM_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_000_7913DB5FA7D3F643A2C10A4A8E2DFAF43A3A5D7C25ILMA1ILNDSCOM_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

I'll try to be as accurate as I can.
Yesterday I downloaded ELDK 4.2 from DENX site and Installed it.
I want to build a Xenomai enabled kernel.
I saw that my kernel is 2.6.24-xenomai and that's what I'm trying to build.
My target is freescale quicc II (MPC8248) and I want to start by building a=
 Xenomai enabled kernel for a target board as close as possible to my custo=
m board.
I know from the old build we had that the defconfig that was used to build =
the kernel was ads8272_defconfig ( I hope some research was done before cho=
osing it... )
It probebly was sufficiently close since it worked fine with some configura=
ions and changes .

My board has 2 flash chips AMD29LV256ML (from which one is the boot memory)=
 , 4SDRAM chips  48LC32M16A2 an FPGA from Xilinx with some logic as a perip=
heral device and that's about it.
It should comunicate with a host PC via Ethernet or via RS-232 serial com.

I'd like to get the following assistance :

A) help in building the kernel as is for this target board without changes =
.
B) hints as to how and where should modifications and changes be made to po=
rt to a custom board .

BTW :
Currently I did :
> make ads8272_defconfig
> make uImage

and I'm failing on :
  CC      drivers/net/fs_enet/mac-fcc.o
drivers/net/fs_enet/mac-fcc.c: In function 'fcc_cr_cmd':
drivers/net/fs_enet/mac-fcc.c:85: error: implicit declaration of function '=
cpm_command'
make[3]: *** [drivers/net/fs_enet/mac-fcc.o] Error 1
make[2]: *** [drivers/net/fs_enet] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2


Best Regards,
Yigal Goldberger.

________________________________
This e-mail is confidential, the property of NDS Ltd and intended for the a=
ddressee only. Any dissemination, copying or distribution of this message o=
r any attachments by anyone other than the intended recipient is strictly p=
rohibited. If you have received this message in error, please immediately n=
otify the postmaster@nds.com and destroy the original message. Messages sen=
t to and from NDS may be monitored. NDS cannot guarantee any message delive=
ry method is secure or error-free. Information could be intercepted, corrup=
ted, lost, destroyed, arrive late or incomplete, or contain viruses. We do =
not accept responsibility for any errors or omissions in this message and/o=
r attachment that arise as a result of transmission. You should carry out y=
our own virus checks before opening any attachment. Any views or opinions p=
resented are solely those of the author and do not necessarily represent th=
ose of NDS.

To protect the environment please do not print this e-mail unless necessary=
.

NDS Limited Registered Office: One London Road, Staines,Middlesex TW18 4EX,=
 United Kingdom. A company registered in England and Wales Registered no. 3=
080780 VAT no. GB 603 8808 40-00

--_000_7913DB5FA7D3F643A2C10A4A8E2DFAF43A3A5D7C25ILMA1ILNDSCOM_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta content=3D"MSHTML 6.00.2900.3492" name=3D"GENERATOR">
</head>
<body>
<div><font face=3D"Arial" size=3D"2">
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">Hi =
All,</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009"></s=
pan></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">I'l=
l try to be as accurate as I can.</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">Yes=
terday I downloaded ELDK 4.2 from DENX site and Installed it.</span></font>=
</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">I w=
ant to build a Xenomai enabled kernel.</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">I s=
aw that my kernel is 2.6.24-xenomai and that's what I'm trying to build.</s=
pan></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">My =
target is freescale quicc II&nbsp;(MPC8248) and I want to start by building=
 a Xenomai enabled kernel for a&nbsp;target&nbsp;board as close as possible=
&nbsp;to my custom board.</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">I k=
now from the old build we had that the&nbsp;defconfig that was used to buil=
d the kernel was ads8272_defconfig ( I&nbsp;hope some research was done bef=
ore choosing it... )</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">It =
probebly was sufficiently close since it worked fine with some configuraion=
s and changes .</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009"><st=
rong><u></u></strong></span></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">My =
board has 2 flash chips AMD29LV256ML (from which one is the boot memory) , =
4SDRAM chips&nbsp; 48LC32M16A2 an FPGA from Xilinx with some logic as a per=
ipheral device and that's about it.</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">It =
should comunicate with a host PC via Ethernet or via RS-232 serial com.</sp=
an></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009"></s=
pan></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">I'd=
 like to get the following assistance&nbsp;:</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009"></s=
pan></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009"><st=
rong><u>A) help in building the kernel as is&nbsp;for this target board wit=
hout changes .</u></strong></span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009"><st=
rong><u>B) hints&nbsp;as to how and where should modifications and changes =
be made to port to a custom board .</u></strong></span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009"></s=
pan></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">BTW=
 :</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">Cur=
rently I did :</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">&gt=
; make ads8272_defconfig
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">&gt=
; make uImage</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009"></s=
pan></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">and=
 I'm failing on :</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">&nb=
sp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/net/fs_enet/mac-fcc.o<br>
drivers/net/fs_enet/mac-fcc.c: In function 'fcc_cr_cmd':<br>
drivers/net/fs_enet/mac-fcc.c:85: error: implicit declaration of function '=
cpm_command'<br>
make[3]: *** [drivers/net/fs_enet/mac-fcc.o] Error 1<br>
make[2]: *** [drivers/net/fs_enet] Error 2<br>
make[1]: *** [drivers/net] Error 2<br>
make: *** [drivers] Error 2</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009"></s=
pan></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009"></s=
pan></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">Bes=
t Regards,</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"731124616-25032009">Yig=
al Goldberger.&nbsp;</span></font></div>
</font></div>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"1">This e-mail is confidential,=
 the property of NDS Ltd and intended for the addressee only. Any dissemina=
tion, copying or distribution of this message or any attachments by anyone =
other than the intended recipient is strictly
 prohibited. If you have received this message in error, please immediately=
 notify the postmaster@nds.com and destroy the original message. Messages s=
ent to and from NDS may be monitored. NDS cannot guarantee any message deli=
very method is secure or error-free.
 Information could be intercepted, corrupted, lost, destroyed, arrive late =
or incomplete, or contain viruses. We do not accept responsibility for any =
errors or omissions in this message and/or attachment that arise as a resul=
t of transmission. You should carry
 out your own virus checks before opening any attachment. Any views or opin=
ions presented are solely those of the author and do not necessarily repres=
ent those of NDS.<br>
<br>
To protect the environment please do not print this e-mail unless necessary=
.<br>
<br>
NDS Limited Registered Office: One London Road, Staines,Middlesex TW18 4EX,=
 United Kingdom. A company registered in England and Wales Registered no. 3=
080780 VAT no. GB 603 8808 40-00<br>
</font>
</body>
</html>

--_000_7913DB5FA7D3F643A2C10A4A8E2DFAF43A3A5D7C25ILMA1ILNDSCOM_--
