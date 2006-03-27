Return-Path: <huangjq@cn.ibm.com>
In-Reply-To: <44270B34.3070406@fugal.net>
To: Hans Fugal <hans@fugal.net>
MIME-Version: 1.0
Subject: Re: make install on ppc
Message-ID: <OF06763F9B.91995CDB-ON4825713E.000850DE-4825713E.000949FE@cn.ibm.com>
From: Jin Qi Huang <huangjq@cn.ibm.com>
Date: Mon, 27 Mar 2006 09:42:36 +0800
Content-Type: multipart/alternative;
	boundary="=_alternative 000949F64825713E_="
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc-dev-bounces+huangjq=cn.ibm.com@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 000949F64825713E_=
Content-Type: text/plain; charset="US-ASCII"

I also think the 'make install' is very useful, now on ia32, the 'make 
install' provided by the latest kernel linux-2.6.16 not only create 
initrd, copy vmlinuz and System.map to /boot directory, but also update 
grub, ppc32 does not provide this useful feature, maybe it is a pity!

--
Regards,

MCP Test, Linux Technology Center, China Systems & Technology Lab
China Development Labs, Beijing      Email: huangjq@cn.ibm.com



Hans Fugal <hans@fugal.net> 
Sent by: linuxppc-dev-bounces+huangjq=cn.ibm.com@ozlabs.org
2006-03-27 05:44

To
Hollis Blanchard <hollis@penguinppc.org>
cc
linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject
Re: make install on ppc






Hollis Blanchard wrote:
> On Mar 21, 2006, at 8:08 AM, Hans Fugal wrote:
> 
>> Is there something that stops us from having a make install target for 
>> ppc?
> 
> Why do you want it, and what would it do? Clearly not many people have 
> needed it so far...

I bet a lot of people have typed it, wished it was there, then worked 
around it. That's what I've been doing for a year now.

It doesn't do much - basically it has the proper dependencies and runs 
installkernel with the appropriate arguments (as indicated by `make 
help`).

Thanks
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev


--=_alternative 000949F64825713E_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">I also think the 'make install' is very
useful, now on ia32, the 'make install' provided by the latest kernel linux-2.6.16
not only create initrd, copy vmlinuz and System.map to /boot directory,
but also update grub, ppc32 does not provide this useful feature, maybe
it is a pity!</font>
<br>
<br><font size=2 face="sans-serif">--<br>
Regards,<br>
<br>
MCP Test, Linux Technology Center, China Systems &amp; Technology Lab<br>
China Development Labs, Beijing &nbsp; &nbsp; &nbsp;Email: huangjq@cn.ibm.com</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Hans Fugal &lt;hans@fugal.net&gt;</b>
</font>
<br><font size=1 face="sans-serif">Sent by: linuxppc-dev-bounces+huangjq=cn.ibm.com@ozlabs.org</font>
<p><font size=1 face="sans-serif">2006-03-27 05:44</font>
<td width=59%>
<table width=100%>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td valign=top><font size=1 face="sans-serif">Hollis Blanchard &lt;hollis@penguinppc.org&gt;</font>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td valign=top><font size=1 face="sans-serif">linuxppc-dev list &lt;linuxppc-dev@ozlabs.org&gt;</font>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td valign=top><font size=1 face="sans-serif">Re: make install on ppc</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2><tt>Hollis Blanchard wrote:<br>
&gt; On Mar 21, 2006, at 8:08 AM, Hans Fugal wrote:<br>
&gt; <br>
&gt;&gt; Is there something that stops us from having a make install target
for <br>
&gt;&gt; ppc?<br>
&gt; <br>
&gt; Why do you want it, and what would it do? Clearly not many people
have <br>
&gt; needed it so far...<br>
<br>
I bet a lot of people have typed it, wished it was there, then worked <br>
around it. That's what I've been doing for a year now.<br>
<br>
It doesn't do much - basically it has the proper dependencies and runs
<br>
installkernel with the appropriate arguments (as indicated by `make help`).<br>
<br>
Thanks<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
Linuxppc-dev@ozlabs.org<br>
https://ozlabs.org/mailman/listinfo/linuxppc-dev<br>
</tt></font>
<br>
--=_alternative 000949F64825713E_=--
