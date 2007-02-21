Return-Path: <Manjunath.AM@Lntemsys.com>
Received: from mail145.messagelabs.com (mail145.messagelabs.com
	[216.82.245.115]) by ozlabs.org (Postfix) with SMTP id 91B7FDDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 15:46:06 +1100 (EST)
In-Reply-To: <20070220190011.09b6b8e6@vitb.dev.rtsoft.ru>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: enabling two eths
MIME-Version: 1.0
Message-ID: <OFEDE45104.191EF09D-ON65257289.001981AA-65257289.001A6E1E@lntemsys.com>
From: Manjunath AM <Manjunath.AM@Lntemsys.com>
Date: Wed, 21 Feb 2007 10:20:21 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 001A6E1C65257289_="
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
--=_alternative 001A6E1C65257289_=
Content-Type: text/plain; charset="US-ASCII"

Hi, Thanks for your kind reply, Yes i have used different * IP Subnets*

The IPs and subnet details I use is
1. eth0(configured through u-boot env settings)->> 192.168.174.231 and 
subnet is 255.255.255.0 
2. eth1(configured after kernel is up)--> 192.168.33.64 and subnet is 
255.255.248.0

Even i tried by connecting second eth to host PC using cross cable as a 
stand-alone network but even "ping" did not work.. 



Thanks & Regards
 MANJUNATH AM
 Senior Software Engineer
 Emsys
 Larsen & Toubro Limited
 Mysore-570018
 Mobile:9886375926




Vitaly Bordug <vbordug@ru.mvista.com> 
02/20/2007 09:30 PM

To
Alex Zeffertt <ajz@cambridgebroadband.com>
cc
Manjunath AM <Manjunath.AM@Lntemsys.com>, linuxppc-embedded@ozlabs.org
Subject
Re: enabling two eths






On Tue, 20 Feb 2007 15:31:54 +0000
Alex Zeffertt <ajz@cambridgebroadband.com> wrote:

> 
> Manjunath AM wrote:
> > 
> > Hi,
> > 
> > We are using MPC8272 based target board, we use montavista Linux 
version 
> > 2.6.10 kernel image (with NFS enabled) to our target board,
> > 
> > Our board has  2 FCCs (eth0 and eth1). bot the eth's works perfectly 
> > when we use them independently, but when we are trying to enable 
second 
> > one after the kernel is up using linux command  "ifconfig eth1 
> > 192.168.33.64 up"(IP address)nothing is working.
> > Please suggest how to enable second eth (either 0 or 1) once the 
kernel 
> > is up with NFS file system
> 
> 
> Have you made sure that eth0 and eth1 are on *different* IP subnets?
> If they are on the same subnet, or intersecting subnets, your routing
> will get confused.
> 
It depends :)

I used to test functionality such a way to have two enets in same subnet, 
then ifdown one of them.

At least with mvista RFS, one enet  handles NFS, other is up but all the 
packets are routed to it via
the first one. And when the first one got ifdown, routing switches to the 
remaining enet...
-- 
Sincerely, 
Vitaly


--=_alternative 001A6E1C65257289_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi, Thanks for your kind reply, Yes
i have used different * IP Subnets*</font>
<br>
<br><font size=2 face="sans-serif">The IPs and subnet details I use is</font>
<br><font size=2 face="sans-serif">1. eth0(configured through u-boot env
settings)-&gt;&gt; 192.168.174.231 and subnet is 255.255.255.0 </font>
<br><font size=2 face="sans-serif">2. eth1(configured after kernel is up)--&gt;
192.168.33.64 and subnet is 255.255.248.0</font>
<br>
<br><font size=2 face="sans-serif">Even i tried by connecting second eth
to host PC using cross cable as a stand-alone network but even &quot;ping&quot;
did not work.. </font>
<br>
<br>
<br>
<br><font size=2 face="sans-serif">Thanks &amp; Regards<br>
 MANJUNATH AM<br>
 Senior Software Engineer<br>
 Emsys<br>
 Larsen &amp; Toubro Limited<br>
 Mysore-570018<br>
 Mobile:9886375926<br>
</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Vitaly Bordug &lt;vbordug@ru.mvista.com&gt;</b>
</font>
<p><font size=1 face="sans-serif">02/20/2007 09:30 PM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">Alex Zeffertt &lt;ajz@cambridgebroadband.com&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">Manjunath AM &lt;Manjunath.AM@Lntemsys.com&gt;,
linuxppc-embedded@ozlabs.org</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: enabling two eths</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2><tt>On Tue, 20 Feb 2007 15:31:54 +0000<br>
Alex Zeffertt &lt;ajz@cambridgebroadband.com&gt; wrote:<br>
<br>
&gt; <br>
&gt; Manjunath AM wrote:<br>
&gt; &gt; <br>
&gt; &gt; Hi,<br>
&gt; &gt; <br>
&gt; &gt; We are using MPC8272 based target board, we use montavista Linux
version <br>
&gt; &gt; 2.6.10 kernel image (with NFS enabled) to our target board,<br>
&gt; &gt; <br>
&gt; &gt; Our board has &nbsp;2 FCCs (eth0 and eth1). bot the eth's works
perfectly <br>
&gt; &gt; when we use them independently, but when we are trying to enable
second <br>
&gt; &gt; one after the kernel is up using linux command &nbsp;&quot;ifconfig
eth1 <br>
&gt; &gt; 192.168.33.64 up&quot;(IP address)nothing is working.<br>
&gt; &gt; Please suggest how to enable second eth (either 0 or 1) once
the kernel <br>
&gt; &gt; is up with NFS file system<br>
&gt; <br>
&gt; <br>
&gt; Have you made sure that eth0 and eth1 are on *different* IP subnets?<br>
&gt; If they are on the same subnet, or intersecting subnets, your routing<br>
&gt; will get confused.<br>
&gt; <br>
It depends :)<br>
<br>
I used to test functionality such a way to have two enets in same subnet,
then ifdown one of them.<br>
<br>
At least with mvista RFS, one enet &nbsp;handles NFS, other is up but all
the packets are routed to it via<br>
the first one. And when the first one got ifdown, routing switches to the
remaining enet...<br>
-- <br>
Sincerely, <br>
Vitaly<br>
</tt></font>
<br>
--=_alternative 001A6E1C65257289_=--
