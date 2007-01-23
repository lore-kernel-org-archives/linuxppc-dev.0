Return-Path: <Manjunath.AM@Lntemsys.com>
Received: from mail130.messagelabs.com (mail130.messagelabs.com
	[216.82.250.163]) by ozlabs.org (Postfix) with SMTP id 1ECE7DDEF0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 00:19:35 +1100 (EST)
In-Reply-To: <45B606CB.4050305@gmx.de>
To: Andre Haupt <haupt.andre@gmx.de>
Subject: Re: nfs mounting problem
MIME-Version: 1.0
Message-ID: <OFEEBC95A7.C19B5826-ON6525726C.004962C8-6525726C.00497146@lntemsys.com>
From: Manjunath AM <Manjunath.AM@Lntemsys.com>
Date: Tue, 23 Jan 2007 18:53:45 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 004971446525726C_="
Cc: kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org
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
--=_alternative 004971446525726C_=
Content-Type: text/plain; charset="US-ASCII"

Thanks for your reply, Yes portmap is running and when i give  netstat -an 
| grep ":111 "  this server shows the below:

tcp        0      0 0.0.0.0:111                 0.0.0.0:*  LISTEN
udp        0      0 0.0.0.0:111                 0.0.0.0:*

Thanks & Regards
 MANJUNATH AM
 Senior Software Engineer
 Emsys
 Larsen & Toubro Limited
 Mysore-570018
 Mobile:9886375926




Andre Haupt <haupt.andre@gmx.de> 
01/23/2007 06:29 PM

To
Manjunath AM <Manjunath.AM@Lntemsys.com>
cc
linuxppc-embedded@ozlabs.org, kernelnewbies@nl.linux.org
Subject
Re: nfs mounting problem






Manjunath AM wrote:
>
> Hi,
Hi,
>
> Looking up port of RPC 100003/2 on 192.168.178.110
> portmap: server 192.168.178.110 not responding, timed out
> Root-NFS: Unable to get nfsd port number >from server, using default
> Looking up port of RPC 100005/1 on 192.168.178.110
> portmap: server 192.168.178.110 not responding, timed out
> Root-NFS: Unable to get mountd port number from server, using default
> mount: server 192.168.178.110 not responding, timed out
> Root-NFS: Server returned error -5 while mounting 
> /opt/montavista/pro/devkit/ppc/82xx/target
> VFS: Unable to mount root fs via NFS, trying floppy.
> VFS: Cannot open root device "nfs" or unknown-block(2,0)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on 
> unknown-block(2,0)
>  <0>Rebooting in 180 seconds..

is portmap actually running?
try ps -e | grep portmap

if it is

netstat -an | grep ":111 "

should report something like this.

tcp 0 0 0.0.0.0:111 0.0.0.0:* LISTEN
udp 0 0 0.0.0.0:111 0.0.0.0:*


Best regards,

Andre



--=_alternative 004971446525726C_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Thanks for your reply, Yes portmap is
running and when i give &nbsp;</font><font size=2><tt>netstat -an | grep
&quot;:111 &quot; </tt></font><font size=2 face="sans-serif">&nbsp;this
server shows the below:</font>
<br>
<br><font size=2><tt>tcp &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp;0
0.0.0.0:111 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0.0.0.0:*
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; LISTEN</tt></font>
<br><font size=2><tt>udp &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp;0
0.0.0.0:111 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0.0.0.0:*</tt></font>
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
<td width=40%><font size=1 face="sans-serif"><b>Andre Haupt &lt;haupt.andre@gmx.de&gt;</b>
</font>
<p><font size=1 face="sans-serif">01/23/2007 06:29 PM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">Manjunath AM &lt;Manjunath.AM@Lntemsys.com&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">linuxppc-embedded@ozlabs.org, kernelnewbies@nl.linux.org</font>
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
<br><font size=2><tt>Manjunath AM wrote:<br>
&gt;<br>
&gt; Hi,<br>
Hi,<br>
&gt;<br>
&gt; Looking up port of RPC 100003/2 on 192.168.178.110<br>
&gt; portmap: server 192.168.178.110 not responding, timed out<br>
&gt; Root-NFS: Unable to get nfsd port number &gt;from server, using default<br>
&gt; Looking up port of RPC 100005/1 on 192.168.178.110<br>
&gt; portmap: server 192.168.178.110 not responding, timed out<br>
&gt; Root-NFS: Unable to get mountd port number from server, using default<br>
&gt; mount: server 192.168.178.110 not responding, timed out<br>
&gt; Root-NFS: Server returned error -5 while mounting <br>
&gt; /opt/montavista/pro/devkit/ppc/82xx/target<br>
&gt; VFS: Unable to mount root fs via NFS, trying floppy.<br>
&gt; VFS: Cannot open root device &quot;nfs&quot; or unknown-block(2,0)<br>
&gt; Please append a correct &quot;root=&quot; boot option<br>
&gt; Kernel panic - not syncing: VFS: Unable to mount root fs on <br>
&gt; unknown-block(2,0)<br>
&gt; &nbsp;&lt;0&gt;Rebooting in 180 seconds..<br>
<br>
is portmap actually running?<br>
try ps -e | grep portmap<br>
<br>
if it is<br>
<br>
netstat -an | grep &quot;:111 &quot;<br>
<br>
should report something like this.<br>
<br>
tcp 0 0 0.0.0.0:111 0.0.0.0:* LISTEN<br>
udp 0 0 0.0.0.0:111 0.0.0.0:*<br>
<br>
<br>
Best regards,<br>
<br>
Andre<br>
<br>
</tt></font>
<br>
--=_alternative 004971446525726C_=--
