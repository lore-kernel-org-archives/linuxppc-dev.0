Return-Path: <Prashant.Yendigeri@lntinfotech.com>
Received: from mail46.messagelabs.com (mail46.messagelabs.com [216.82.241.227])
	by ozlabs.org (Postfix) with SMTP id 180CB67B77
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 21:21:26 +1000 (EST)
In-Reply-To: <E5C22C0A-45C9-4FA8-B10D-8F3EBDA03878@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 : different
	outputs
MIME-Version: 1.0
Message-ID: <OF8FBDC92D.1A664660-ON652571C7.003DFE8F-652571C7.003E60DC@lntinfotech.com>
From: Prashant Yendigeri <Prashant.Yendigeri@lntinfotech.com>
Date: Fri, 11 Aug 2006 16:51:20 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 003E60D5652571C7_="
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
--=_alternative 003E60D5652571C7_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

Downloaded 2.6.16.26 and booted up and got this :

/ # ifconfig eth0 172.28.8.254 up
[   34.034596] 0:00 not found
[   34.037330] eth0: Could not attach to PHY
[   34.041809] 0:00 not found
SIOCSIFFLAGS: No[   34.044526] eth0: Could not attach to PHY
 such device
SIOCSIFFLAGS: No such device

I had enabled all the PHY devices in .config and also tried only with 
Marvell phy enabled.

Kernel boot messages :
[    2.296555] Gianfar MII Bus: probed
[    2.301789] eth0: Gianfar Ethernet Controller Version 1.2, 
00:01:af:07:9b:8a

[    2.309039] eth0: Running with NAPI disabled
[    2.313307] eth0: 64/64 RX/TX BD ring size
[    2.318498] eth1: Gianfar Ethernet Controller Version 1.2, 
00:00:00:00:72:6f

[    2.325738] eth1: Running with NAPI disabled
[    2.330006] eth1: 64/64 RX/TX BD ring size
[    2.335198] eth2: Gianfar Ethernet Controller Version 1.2, 
6f:74:3d:2f:64:65

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
Prashant Yendigeri <Prashant.Yendigeri@lntinfotech.com>
cc
linuxppc-embedded@ozlabs.org
Subject
Re: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 : different outputs







On Aug 10, 2006, at 6:18 AM, Prashant Yendigeri wrote:

>
> Hi,
>
> The gianfar driver of 2.6.12 and 2.4.20 give different outputs on 
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

It looks like your 2.6.12 kernel isn't handling the PHY correctly. 
I'd recommend upgrading to something newer which has the phylib 
(can't remember which 2.6 that went into).

- kumar

______________________________________________________________________



______________________________________________________________________
--=_alternative 003E60D5652571C7_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">Downloaded 2.6.16.26 and booted up and
got this :</font>
<br>
<br><font size=2 face="sans-serif">/ # ifconfig eth0 172.28.8.254 up</font>
<br><font size=2 face="sans-serif">[ &nbsp; 34.034596] 0:00 not found</font>
<br><font size=2 face="sans-serif">[ &nbsp; 34.037330] eth0: Could not
attach to PHY</font>
<br><font size=2 face="sans-serif">[ &nbsp; 34.041809] 0:00 not found</font>
<br><font size=2 face="sans-serif">SIOCSIFFLAGS: No[ &nbsp; 34.044526]
eth0: Could not attach to PHY</font>
<br><font size=2 face="sans-serif">&nbsp;such device</font>
<br><font size=2 face="sans-serif">SIOCSIFFLAGS: No such device</font>
<br>
<br><font size=2 face="sans-serif">I had enabled all the PHY devices in
.config and also tried only with Marvell phy enabled.</font>
<br>
<br><font size=2 face="sans-serif">Kernel boot messages :</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.296555] Gianfar MII
Bus: probed</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.301789] eth0: Gianfar
Ethernet Controller Version 1.2, 00:01:af:07:9b:8a</font>
<br>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.309039] eth0: Running
with NAPI disabled</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.313307] eth0: 64/64
RX/TX BD ring size</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.318498] eth1: Gianfar
Ethernet Controller Version 1.2, 00:00:00:00:72:6f</font>
<br>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.325738] eth1: Running
with NAPI disabled</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.330006] eth1: 64/64
RX/TX BD ring size</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.335198] eth2: Gianfar
Ethernet Controller Version 1.2, 6f:74:3d:2f:64:65</font>
<br>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.342377] eth2: Running
with NAPI disabled</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.346662] eth2: 64/64
RX/TX BD ring size</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.351586] Marvell 88E1101:
Registered new driver</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.357010] Davicom DM9161E:
Registered new driver</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.362443] Davicom DM9131:
Registered new driver</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.367775] Cicada Cis8204:
Registered new driver</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.373136] LXT970: Registered
new driver</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.377794] LXT971: Registered
new driver</font>
<br><font size=2 face="sans-serif">[ &nbsp; &nbsp;2.382461] QS6612: Registered
new driver</font>
<br>
<br>
<br><font size=2 face="sans-serif">Regards,</font>
<br><font size=2 face="sans-serif">Prashant </font>
<br>
<br>
<br>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Kumar Gala &lt;galak@kernel.crashing.org&gt;</b>
</font>
<p><font size=1 face="sans-serif">08/11/2006 09:40 AM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">Prashant Yendigeri &lt;Prashant.Yendigeri@lntinfotech.com&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">linuxppc-embedded@ozlabs.org</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: Gianfar eth driver on 8540 ppc -
for 2.4 and 2.6 : different outputs</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><tt><font size=2><br>
On Aug 10, 2006, at 6:18 AM, Prashant Yendigeri wrote:<br>
<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; The gianfar driver of 2.6.12 and 2.4.20 give different outputs on
&nbsp;<br>
&gt; the same PPC 8540 board.<br>
&gt;<br>
&gt; What could be the reason ?<br>
&gt;<br>
&gt; Output on 2.4.20 :<br>
&gt; /root # ifconfig eth0 172.28.8.254 up<br>
&gt; eth0: PHY is Marvell 88E1011S (1410c62)<br>
&gt; eth0: Auto-negotiation done<br>
&gt; eth0: Half Duplex<br>
&gt; eth0: Speed 10BT<br>
&gt; eth0: Link is up<br>
&gt;<br>
&gt; Output on 2.6.12<br>
&gt; / # ifconfig eth0 172.28.8.254 up<br>
&gt; &nbsp;eth0: PHY is Generic MII (ffffffff)<br>
<br>
It looks like your 2.6.12 kernel isn't handling the PHY correctly. &nbsp;
<br>
I'd recommend upgrading to something newer which has the phylib &nbsp;<br>
(can't remember which 2.6 that went into).<br>
<br>
- kumar<br>
<br>
______________________________________________________________________<br>
</font></tt>
<br>

<BR>
______________________________________________________________________<BR>

--=_alternative 003E60D5652571C7_=--
