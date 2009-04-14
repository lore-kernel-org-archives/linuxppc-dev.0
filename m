Return-Path: <sjy1937@hotmail.com>
Received: from bay0-omc1-s17.bay0.hotmail.com (bay0-omc1-s17.bay0.hotmail.com
	[65.54.246.89]) by ozlabs.org (Postfix) with ESMTP id AD6A7DDFC3
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 17:56:25 +1000 (EST)
Message-ID: <BAY112-W200D1650425A8B738616C9A37C0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_e2fd3473-b36a-4a3b-bfc9-cf37d2058483_"
From: =?ks_c_5601-1987?B?wOe/6yC9xQ==?= <sjy1937@hotmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: Has anyone debugged kernel 2.6.27 using KGDB?
Date: Tue, 14 Apr 2009 07:51:18 +0000
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_e2fd3473-b36a-4a3b-bfc9-cf37d2058483_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 8bit


Hi all.

Has anyone tried to debug kernel 2.6.27 using KGDB?

I'm now trying to use KGDB but I can't use it at all.

I already red documents in kernel source about KGDB and I also know that KGDB is merged since 2.6.26.

Absoultely I'm already done what I have to do in menuconfig like

 

enable KGDB option

enable tty serial

enabel compile with .. and so on..

 

I have embedded board that is target (PXA270, v2.6.27 android kernel) and development PC that is host(2.6.23)

 

Is that a problem that I use lower version kernel in host system?

 

I attached boot parameter in menucofig as follow:

kgdbwait kgdb8250=ttyS0,115200

but When bootloader(BLOB) is loading kernel in embedded board, kernel never wait for host side' gdb signal.

Is there something I missed?

 

I'm now confused slightly. plz help me. o<-< 

 

thanks in advance.

 

Sincerely

 

Shin Jaeyong.

_________________________________________________________________
Show them the way! Add maps and directions to your party invites. 
http://www.microsoft.com/windows/windowslive/products/events.aspx
--_e2fd3473-b36a-4a3b-bfc9-cf37d2058483_
Content-Type: text/html; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
</style>
</head>
<body class='hmmessage'>
Hi all.<BR>
Has anyone tried to debug kernel 2.6.27 using KGDB?<BR>
I'm now trying to use KGDB but I can't use it at all.<BR>
I already red documents in kernel source about KGDB and I also know that KGDB is merged since 2.6.26.<BR>
Absoultely I'm already done what I have to do in menuconfig like<BR>
&nbsp;<BR>
enable KGDB option<BR>
enable tty serial<BR>
enabel compile with .. and so on..<BR>
&nbsp;<BR>
I have embedded board that is target (PXA270, v2.6.27 android kernel) and development PC that is host(2.6.23)<BR>
&nbsp;<BR>
Is that a problem that I use lower version kernel in host system?<BR>
&nbsp;<BR>
I attached boot parameter in menucofig as follow:<BR>
kgdbwait kgdb8250=ttyS0,115200<BR>
but When bootloader(BLOB) is loading kernel in embedded board, kernel never wait for host side' gdb signal.<BR>
Is there something I missed?<BR>
&nbsp;<BR>
I'm now confused slightly. plz help me. o&lt;-&lt; <BR>
&nbsp;<BR>
thanks in advance.<BR>
&nbsp;<BR>
Sincerely<BR>
&nbsp;<BR>
Shin Jaeyong.<BR><br /><hr />See all the ways you can stay connected <a href='http://www.microsoft.com/windows/windowslive/default.aspx' target='_new'>to friends and family</a></body>
</html>
--_e2fd3473-b36a-4a3b-bfc9-cf37d2058483_--
