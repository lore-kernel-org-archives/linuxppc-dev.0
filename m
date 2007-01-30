Return-Path: <Manjunath.AM@Lntemsys.com>
In-Reply-To: <45B7146F.90402@gmx.de>
To: Andre Haupt <haupt.andre@gmx.de>
Subject: Re: nfs mounting problem
MIME-Version: 1.0
Message-ID: <OFF04B15E6.FDDCE036-ON65257273.0064EE20-65257273.00668C60@lntemsys.com>
From: Manjunath AM <Manjunath.AM@Lntemsys.com>
Date: Wed, 31 Jan 2007 00:11:40 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 00668C5E65257273_="
Cc: kernelnewbies@nl.linux.org,
	linuxppc-embedded-bounces+manjunath.am=lntemsys.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
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
--=_alternative 00668C5E65257273_=
Content-Type: text/plain; charset="US-ASCII"

Thanks for the inputs,
We are still in the process of debugging the nfs mounting for our target 
board,
there were Tx clock and Rx clock pins  in our board were different as 
compared to MPC8272ADS board and we configured  PC_F2RXCLK and PC_F2TXCLK 
macro,s accordingly in \arch\ppc\8260_io\fcc_enet.c.
still nfs is not up.. same error " Root-NFS: Server returned error -5 
while mounting /opt/montavista/pro/devkit/ppc//82xx/target" is comming up.

We verified " immr->im_cpmux.cmx_fcr = 0x2c0000" reg value both in 
bootloader and kernel, both are same but ethernet works in u-boot and does 
not work in kernel.
Please suggest how we can attack this problem.
Thanks
Manjunath AM





Andre Haupt <haupt.andre@gmx.de> 
Sent by: linuxppc-embedded-bounces+manjunath.am=lntemsys.com@ozlabs.org
01/24/2007 01:40 PM

To
Scott Wood <scottwood@freescale.com>
cc
kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org, Manjunath AM 
<Manjunath.AM@Lntemsys.com>
Subject
Re: nfs mounting problem






Scott Wood wrote:
> Andre Haupt wrote:
>> Also what seems a bit odd to me is that your dmesg shows no rootpath
>>
>>  IP-Config: Complete:
>>       device=eth1, addr=192.168.178.234, mask=255.255.255.0, 
>> gw=192.168.178.47,
>>      host=cashel, domain=, nis-domain=(none),
>>      bootserver=192.168.178.110, rootserver=192.168.178.110, rootpath=
>>
>> On my system the complete root path is printed here.
>
> I don't think I've ever seen the root path printed there (with nfsroot 
> otherwise working), so I don't think that's the problem...  From 
> looking at the code, it seems that the root path received from BOOTP 
> is stored in a different variable than the path from the nfsroot boot 
> option, and it's the former that gets printed there.
Ahh, ok. I am using BOOTP, so this has nothing to do with Manjunaths 
problem. Thanks for clarification.

Best,

Andre
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


--=_alternative 00668C5E65257273_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Thanks for the inputs,</font>
<br><font size=2 face="sans-serif">We are still in the process of debugging
the nfs mounting for our target board,</font>
<br><font size=2 face="sans-serif">there were Tx clock and Rx clock pins
&nbsp;in our board were different as compared to MPC8272ADS board and we
configured &nbsp;PC_F2RXCLK and PC_F2TXCLK macro,s accordingly in \arch\ppc\8260_io\fcc_enet.c.</font>
<br><font size=2 face="sans-serif">still nfs is not up.. same error &quot;
Root-NFS: Server returned error -5 while mounting /opt/montavista/pro/devkit/ppc//82xx/target&quot;
is comming up.</font>
<br>
<br><font size=2 face="sans-serif">We verified &quot; immr-&gt;im_cpmux.cmx_fcr
= 0x2c0000&quot; reg value both in bootloader and kernel, both are same
but ethernet works in u-boot and does not work in kernel.</font>
<br><font size=2 face="sans-serif">Please suggest how we can attack this
problem.</font>
<br><font size=2 face="sans-serif">Thanks</font>
<br><font size=2 face="sans-serif">Manjunath AM</font>
<br><font size=2 face="sans-serif"><br>
</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Andre Haupt &lt;haupt.andre@gmx.de&gt;</b>
</font>
<br><font size=1 face="sans-serif">Sent by: linuxppc-embedded-bounces+manjunath.am=lntemsys.com@ozlabs.org</font>
<p><font size=1 face="sans-serif">01/24/2007 01:40 PM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">Scott Wood &lt;scottwood@freescale.com&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org,
Manjunath AM &lt;Manjunath.AM@Lntemsys.com&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: nfs mounting problem</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2><tt>Scott Wood wrote:<br>
&gt; Andre Haupt wrote:<br>
&gt;&gt; Also what seems a bit odd to me is that your dmesg shows no rootpath<br>
&gt;&gt;<br>
&gt;&gt; &nbsp;IP-Config: Complete:<br>
&gt;&gt; &nbsp; &nbsp; &nbsp; device=eth1, addr=192.168.178.234, mask=255.255.255.0,
<br>
&gt;&gt; gw=192.168.178.47,<br>
&gt;&gt; &nbsp; &nbsp; &nbsp;host=cashel, domain=, nis-domain=(none),<br>
&gt;&gt; &nbsp; &nbsp; &nbsp;bootserver=192.168.178.110, rootserver=192.168.178.110,
rootpath=<br>
&gt;&gt;<br>
&gt;&gt; On my system the complete root path is printed here.<br>
&gt;<br>
&gt; I don't think I've ever seen the root path printed there (with nfsroot
<br>
&gt; otherwise working), so I don't think that's the problem... &nbsp;From
<br>
&gt; looking at the code, it seems that the root path received from BOOTP
<br>
&gt; is stored in a different variable than the path from the nfsroot boot
<br>
&gt; option, and it's the former that gets printed there.<br>
Ahh, ok. I am using BOOTP, so this has nothing to do with Manjunaths <br>
problem. Thanks for clarification.<br>
<br>
Best,<br>
<br>
Andre<br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
Linuxppc-embedded@ozlabs.org<br>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded<br>
</tt></font>
<br>
--=_alternative 00668C5E65257273_=--
