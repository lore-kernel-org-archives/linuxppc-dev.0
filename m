Return-Path: <gnathita@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.194])
	by ozlabs.org (Postfix) with ESMTP id 32C99688D5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 20:25:39 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 71so1005195wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 01:25:38 -0800 (PST)
Message-ID: <259581790512190125g71398455tea4124b2e4f28d8d@mail.gmail.com>
Date: Mon, 19 Dec 2005 10:25:37 +0100
From: =?ISO-8859-1?Q?Paula_Saame=F1o?= <gnathita@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_36434_1744905.1134984337986"
Subject: Problem loading modules
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_36434_1744905.1134984337986
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

First of all, Merry Xmas!!

I'm working with a ml403 board, porting Linux 2.4.devel on it. I got the OS
running, but I cannot load modules.
When I try "modprobe /lib/modules/<version>/kernel/net/<module.o>, I obtain
the error messages:
Note: /etc/modules.conf is more recent than
/lib/modules/<version>/modules.dep
modprobe: Can't locate module lib/modules/<version>/kernel/net/<module.o>

Do you know what is going on?

Thanks!!

Paula Saameno

------=_Part_36434_1744905.1134984337986
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,<br>
<br>
First of all, Merry Xmas!!<br>
<br>
I'm working with a ml403 board, porting Linux 2.4.devel on it. I got the OS=
 running, but I cannot load modules.<br>
When I try &quot;modprobe /lib/modules/&lt;version&gt;/kernel/net/&lt;modul=
e.o&gt;, I obtain the error messages:<br>
Note: /etc/modules.conf is more recent than /lib/modules/&lt;version&gt;/mo=
dules.dep<br>
modprobe: Can't locate module lib/modules/&lt;version&gt;/kernel/net/&lt;mo=
dule.o&gt;<br>
<br>
Do you know what is going on?<br>
<br>
Thanks!!<br>
<br>
Paula Saameno<br>


------=_Part_36434_1744905.1134984337986--
