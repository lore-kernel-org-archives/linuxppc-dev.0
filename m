Return-Path: <Prashant.Yendigeri@lntinfotech.com>
Received: from mail41.messagelabs.com (mail41.messagelabs.com [216.82.242.51])
	by ozlabs.org (Postfix) with SMTP id 00CA367B81
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 19:33:42 +1000 (EST)
In-Reply-To: <3140C9D90FB6D911ABD7000F206DC9260759B2E0@zhk08exm40.ap.freescale.net>
To: Ho Jeffrey-r26191 <r26191@freescale.com>
Subject: RE: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 : different
	outputs
MIME-Version: 1.0
Message-ID: <OF3EFEEE4F.C1FFA5F2-ON652571CD.00345D42-652571CD.003481A2@lntinfotech.com>
From: Prashant Yendigeri <Prashant.Yendigeri@lntinfotech.com>
Date: Thu, 17 Aug 2006 15:03:30 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 00348199652571CD_="
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 00348199652571CD_=
Content-Type: text/plain; charset="US-ASCII"

Hi,
This is what i am getting from u-boot print messages :

U-Boot 1.1.0(pq3-20040423-r1) (May  5 2006 - 08:56:54)

Freescale PowerPC
    Core: E500, Version: 2.0, (0x80200020)
    System: 8540, Version: 2.0, (0x80300020)
    Clocks: CPU: 660 MHz, CCB: 264 MHz, DDR: 132 MHz, LBC:  66 MHz
    L1 D-cache 32KB, L1 I-cache 32KB enabled.
Board: Freescale EVAL8540 Board
        CPU: 660 MHz
        CCB: 264 MHz
        DDR: 132 MHz
        LBC: 66 MHz
L1 D-cache 32KB, L1 I-cache 32KB enabled.
I2C:   ready
DRAM:  256 MB
FLASH:  8 MB
L2 cache enabled: 256KB
In:    serial
Out:   serial
Err:   serial
Net:   Freescale ENET0: PHY is Marvell 88E1011S (1410c62)
Freescale ENET1: PHY is Marvell 88E1011S (1410c62)
Freescale ENET2: PHY is Intel LXT971A (1378e2)
Freescale ENET0, Freescale ENET1, Freescale ENET2
Hit any key to stop autoboot:  0
MPC8540EVAL=>
MPC8540EVAL=>

This seems to me it is a old board from GDATECH . Data sheet not available 
for this.


-prashant 



Ho Jeffrey-r26191 <r26191@freescale.com> 
08/12/2006 06:32 AM

To
"'Prashant Yendigeri'" <Prashant.Yendigeri@lntinfotech.com>, Kumar Gala 
<galak@kernel.crashing.org>
cc
linuxppc-embedded@ozlabs.org
Subject
RE: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 : different outputs






Hi
 
>>>>[   34.041809] 0:00 not found 
SIOCSIFFLAGS: No[   34.044526] eth0: Could not attach to PHY 
 such device 
SIOCSIFFLAGS: No such device 
>>>>>  eth0: PHY is Generic MII (ffffffff)
_______________________________________________________
Can you quickly check if you have the right phy id written in your 
platform file for your board?

Regards, 
Jeffrey Ho 
Freescale Semiconductor HK Ltd 


 


________________________________

                 From: 
linuxppc-embedded-bounces+r26191=freescale.com@ozlabs.org 
[mailto:linuxppc-embedded-bounces+r26191=freescale.com@ozlabs.org] On 
Behalf Of Prashant Yendigeri
                 Sent: Friday, August 11, 2006 7:21 PM
                 To: Kumar Gala
                 Cc: linuxppc-embedded@ozlabs.org
                 Subject: Re: Gianfar eth driver on 8540 ppc - for 2.4 and 
2.6 : different outputs
 
 

                 Hi, 
 
                 Downloaded 2.6.16.26 and booted up and got this : 
 
                 / # ifconfig eth0 172.28.8.254 up 
                 [   34.034596] 0:00 not found 
                 [   34.037330] eth0: Could not attach to PHY 
                 [   34.041809] 0:00 not found 
                 SIOCSIFFLAGS: No[   34.044526] eth0: Could not attach to 
PHY 
                  such device 
                 SIOCSIFFLAGS: No such device 
 
                 I had enabled all the PHY devices in .config and also 
tried only with Marvell phy enabled. 
 
                 Kernel boot messages : 
                 [    2.296555] Gianfar MII Bus: probed 
                 [    2.301789] eth0: Gianfar Ethernet Controller Version 
1.2, 00:01:af:07:9b:8a 
 
                 [    2.309039] eth0: Running with NAPI disabled 
                 [    2.313307] eth0: 64/64 RX/TX BD ring size 
                 [    2.318498] eth1: Gianfar Ethernet Controller Version 
1.2, 00:00:00:00:72:6f 
 
                 [    2.325738] eth1: Running with NAPI disabled 
                 [    2.330006] eth1: 64/64 RX/TX BD ring size 
                 [    2.335198] eth2: Gianfar Ethernet Controller Version 
1.2, 6f:74:3d:2f:64:65 
 
                 [    2.342377] eth2: Running with NAPI disabled 
                 [    2.346662] eth2: 64/64 RX/TX BD ring size 
                 [    2.351586] Marvell 88E1101: Registered new driver 
                 [    2.357010] Davicom DM9161E: Registered new driver 
                 [    2.362443] Davicom DM9131: Registered new driver 
                 [    2.367775] Cicada Cis8204: Registered new driver 
                 [    2.373136] LXT970: Registered new driver 
                 [    2.377794] LXT971: Registered new driver 
                 [    2.382461] QS6612: Registered new driver 
 
 
                 Regards, 
                 Prashant 
 
 
 
 
 
 
                 Kumar Gala <galak@kernel.crashing.org> 

                 08/11/2006 09:40 AM 

 
                                 To
                                 Prashant Yendigeri 
<Prashant.Yendigeri@lntinfotech.com> 
                                 cc
                                 linuxppc-embedded@ozlabs.org 
                                 Subject
                                 Re: Gianfar eth driver on 8540 ppc - for 
2.4 and 2.6 : different outputs

 




 
                 On Aug 10, 2006, at 6:18 AM, Prashant Yendigeri wrote:
 
                 >
                 > Hi,
                 >
                 > The gianfar driver of 2.6.12 and 2.4.20 give different 
outputs on 
                 > the same PPC 8540 board.
                 >
                 > What could be the reason ?
                 >
                 > Output on 2.4.20 :
                 > /root # ifconfig eth0 172.28.8.254 up
                 > eth0: PHY is Marvell 88E1011S (1410c62)
                 > eth0: Auto-negotiation done
                 > eth0: Half Duplex
                 > eth0: Speed 10BT
                 > eth0: Link is up
                 >
                 > Output on 2.6.12
                 > / # ifconfig eth0 172.28.8.254 up
                 >  eth0: PHY is Generic MII (ffffffff)
 
                 It looks like your 2.6.12 kernel isn't handling the PHY 
correctly. 
                 I'd recommend upgrading to something newer which has the 
phylib 
                 (can't remember which 2.6 that went into).
 
                 - kumar
 
 ______________________________________________________________________
 
 
 ______________________________________________________________________
 


______________________________________________________________________



______________________________________________________________________
--=_alternative 00348199652571CD_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br><font size=2 face="sans-serif">This is what i am getting from u-boot
print messages :</font>
<br>
<br><font size=2 face="sans-serif">U-Boot 1.1.0(pq3-20040423-r1) (May &nbsp;5
2006 - 08:56:54)</font>
<br>
<br><font size=2 face="sans-serif">Freescale PowerPC</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; Core: E500, Version: 2.0,
(0x80200020)</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; System: 8540, Version:
2.0, (0x80300020)</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; Clocks: CPU: 660 MHz,
CCB: 264 MHz, DDR: 132 MHz, LBC: &nbsp;66 MHz</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; L1 D-cache 32KB, L1 I-cache
32KB enabled.</font>
<br><font size=2 face="sans-serif">Board: Freescale EVAL8540 Board</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; CPU: 660
MHz</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; CCB: 264
MHz</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; DDR: 132
MHz</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; LBC: 66
MHz</font>
<br><font size=2 face="sans-serif">L1 D-cache 32KB, L1 I-cache 32KB enabled.</font>
<br><font size=2 face="sans-serif">I2C: &nbsp; ready</font>
<br><font size=2 face="sans-serif">DRAM: &nbsp;256 MB</font>
<br><font size=2 face="sans-serif">FLASH: &nbsp;8 MB</font>
<br><font size=2 face="sans-serif">L2 cache enabled: 256KB</font>
<br><font size=2 face="sans-serif">In: &nbsp; &nbsp;serial</font>
<br><font size=2 face="sans-serif">Out: &nbsp; serial</font>
<br><font size=2 face="sans-serif">Err: &nbsp; serial</font>
<br><font size=2 face="sans-serif">Net: &nbsp; Freescale ENET0: PHY is
Marvell 88E1011S (1410c62)</font>
<br><font size=2 face="sans-serif">Freescale ENET1: PHY is Marvell 88E1011S
(1410c62)</font>
<br><font size=2 face="sans-serif">Freescale ENET2: PHY is Intel LXT971A
(1378e2)</font>
<br><font size=2 face="sans-serif">Freescale ENET0, Freescale ENET1, Freescale
ENET2</font>
<br><font size=2 face="sans-serif">Hit any key to stop autoboot: &nbsp;0</font>
<br><font size=2 face="sans-serif">MPC8540EVAL=&gt;</font>
<br><font size=2 face="sans-serif">MPC8540EVAL=&gt;</font>
<br>
<br><font size=2 face="sans-serif">This seems to me it is a old board from
GDATECH . Data sheet not available for this.</font>
<br>
<br>
<br><font size=2 face="sans-serif">-prashant </font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Ho Jeffrey-r26191 &lt;r26191@freescale.com&gt;</b>
</font>
<p><font size=1 face="sans-serif">08/12/2006 06:32 AM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">&quot;'Prashant Yendigeri'&quot; &lt;Prashant.Yendigeri@lntinfotech.com&gt;,
Kumar Gala &lt;galak@kernel.crashing.org&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">linuxppc-embedded@ozlabs.org</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">RE: Gianfar eth driver on 8540 ppc -
for 2.4 and 2.6 : different &nbsp; &nbsp; &nbsp; &nbsp; outputs</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><tt><font size=2>Hi<br>
 <br>
&gt;&gt;&gt;&gt;[ &nbsp; 34.041809] 0:00 not found <br>
SIOCSIFFLAGS: No[ &nbsp; 34.044526] eth0: Could not attach to PHY <br>
 such device <br>
SIOCSIFFLAGS: No such device <br>
&gt;&gt;&gt;&gt;&gt; &nbsp;eth0: PHY is Generic MII (ffffffff)<br>
_______________________________________________________<br>
Can you quickly check if you have the right phy id written in your platform
file for your board?<br>
<br>
Regards, <br>
Jeffrey Ho <br>
Freescale Semiconductor HK Ltd <br>
<br>
<br>
 <br>
<br>
<br>
________________________________<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
From: linuxppc-embedded-bounces+r26191=freescale.com@ozlabs.org [mailto:linuxppc-embedded-bounces+r26191=freescale.com@ozlabs.org]
On Behalf Of Prashant Yendigeri<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Sent: Friday, August 11, 2006 7:21 PM<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
To: Kumar Gala<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Cc: linuxppc-embedded@ozlabs.org<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Subject: Re: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 : different
outputs<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Hi, <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Downloaded 2.6.16.26 and booted up and got this : <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/ # ifconfig eth0 172.28.8.254 up <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; 34.034596] 0:00 not found <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; 34.037330] eth0: Could not attach to PHY <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; 34.041809] 0:00 not found <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
SIOCSIFFLAGS: No[ &nbsp; 34.044526] eth0: Could not attach to PHY <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;such device <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
SIOCSIFFLAGS: No such device <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
I had enabled all the PHY devices in .config and also tried only with Marvell
phy enabled. <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Kernel boot messages : <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.296555] Gianfar MII Bus: probed <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.301789] eth0: Gianfar Ethernet Controller Version 1.2,
00:01:af:07:9b:8a <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.309039] eth0: Running with NAPI disabled <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.313307] eth0: 64/64 RX/TX BD ring size <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.318498] eth1: Gianfar Ethernet Controller Version 1.2,
00:00:00:00:72:6f <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.325738] eth1: Running with NAPI disabled <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.330006] eth1: 64/64 RX/TX BD ring size <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.335198] eth2: Gianfar Ethernet Controller Version 1.2,
6f:74:3d:2f:64:65 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.342377] eth2: Running with NAPI disabled <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.346662] eth2: 64/64 RX/TX BD ring size <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.351586] Marvell 88E1101: Registered new driver <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.357010] Davicom DM9161E: Registered new driver <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.362443] Davicom DM9131: Registered new driver <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.367775] Cicada Cis8204: Registered new driver <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.373136] LXT970: Registered new driver <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.377794] LXT971: Registered new driver <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
[ &nbsp; &nbsp;2.382461] QS6612: Registered new driver <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Regards, <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Prashant <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Kumar Gala &lt;galak@kernel.crashing.org&gt; <br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
08/11/2006 09:40 AM <br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;To<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Prashant
Yendigeri &lt;Prashant.Yendigeri@lntinfotech.com&gt; <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;cc<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;linuxppc-embedded@ozlabs.org
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Subject<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Re:
Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 : different outputs<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
<br>
<br>
<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
On Aug 10, 2006, at 6:18 AM, Prashant Yendigeri wrote:<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt; Hi,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt; The gianfar driver of 2.6.12 and 2.4.20 give different outputs on
&nbsp;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt; the same PPC 8540 board.<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt; What could be the reason ?<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt; Output on 2.4.20 :<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt; /root # ifconfig eth0 172.28.8.254 up<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt; eth0: PHY is Marvell 88E1011S (1410c62)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt; eth0: Auto-negotiation done<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt; eth0: Half Duplex<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt; eth0: Speed 10BT<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt; eth0: Link is up<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt; Output on 2.6.12<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt; / # ifconfig eth0 172.28.8.254 up<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&gt; &nbsp;eth0: PHY is Generic MII (ffffffff)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
It looks like your 2.6.12 kernel isn't handling the PHY correctly. &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
I'd recommend upgrading to something newer which has the phylib &nbsp;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
(can't remember which 2.6 that went into).<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
- kumar<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
______________________________________________________________________<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
______________________________________________________________________<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<br>
<br>
<br>
______________________________________________________________________<br>
</font></tt>
<br>

<BR>
______________________________________________________________________<BR>

--=_alternative 00348199652571CD_=--
