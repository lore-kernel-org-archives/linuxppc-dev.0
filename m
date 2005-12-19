Return-Path: <gnathita@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.194])
	by ozlabs.org (Postfix) with ESMTP id EA19468802
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 03:22:11 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 71so1070671wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 08:22:10 -0800 (PST)
Message-ID: <259581790512190822k53a30ca9j803734367b60e17c@mail.gmail.com>
Date: Mon, 19 Dec 2005 17:22:10 +0100
From: =?ISO-8859-1?Q?Paula_Saame=F1o?= <gnathita@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2194_16256121.1135009330282"
Subject: Re: Problem loading modules
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_2194_16256121.1135009330282
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>>Hi!

>>I'm working with a ml403 board, porting Linux 2.4.devel on it. I got the
OS
>>running, but I cannot load modules.
>>When I try "modprobe /lib/modules/<version>/kernel/net/<module.o>, I
obtain
>>the error messages:
>>Note: /etc/modules.conf is more recent than
>>/lib/modules/<version>/modules.dep
>>modprobe: Can't locate module lib/modules/<version>/kernel/net/<module.o>

>did you try with insmod ?

>then try running depmod.

Yes, I tried with insmod and the error then was: "couldn't find the kernel
version the module was compiled for"

In modules.dep, the references are ok.

Greetings!

------=_Part_2194_16256121.1135009330282
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

&gt;&gt;Hi!<br>
<br>
&gt;&gt;I'm working with a ml403 board, porting Linux 2.4.devel on it. I go=
t the OS<br>
&gt;&gt;running, but I cannot load modules.<br>
&gt;&gt;When I try &quot;modprobe /lib/modules/&lt;version&gt;/kernel/net/&=
lt;module.o&gt;, I obtain<br>&gt;&gt;the error messages:<br>&gt;&gt;Note: /=
etc/modules.conf is more recent than<br>&gt;&gt;/lib/modules/&lt;version&gt=
;/modules.dep
<br>&gt;&gt;modprobe: Can't locate module lib/modules/&lt;version&gt;/kerne=
l/net/&lt;module.o&gt;<br><br>&gt;did you try with insmod ?<br><br>&gt;then=
 try running depmod.<br>
<br>
Yes, I tried with insmod and the error then was: &quot;couldn't find the ke=
rnel version the module was compiled for&quot;<br>
<br>
In modules.dep, the references are ok.<br>
<br>
Greetings!<br>
<br>

------=_Part_2194_16256121.1135009330282--
