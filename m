Return-Path: <kkboyanov@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.202])
	by ozlabs.org (Postfix) with ESMTP id 1A40967B69
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 May 2006 19:54:23 +1000 (EST)
Received: by xproxy.gmail.com with SMTP id s17so1673917wxc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 01 May 2006 02:54:21 -0700 (PDT)
Message-ID: <929bf310605010254j5b9afccdw@mail.gmail.com>
Date: Mon, 1 May 2006 11:54:21 +0200
From: "Konstantin Boyanov" <kkboyanov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Building custom 2.6 kernel
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5549_15162349.1146477261375"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_5549_15162349.1146477261375
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,

These days I'm trying to compile and get working a 2.6 kernel for the
Motorola MVME6100 VME single board computer. For the purpose I'm using an
ELinOS IDE by the SysGo company (don't ask me why, it's the boss' decision)=
.
Since ELinOS lacks support I post here with the hope of getting some help.
Thus far I have succeeded in only compiling a bare kernel but not getting i=
t
up. There is a running RedHat distro on the board but I want to get a
customized cernel for it, because RedHat does not support certain stuff
(like VME drivers for example).
So, the kernel I compiled seems to be quite messy, as you can see from the
dmesg at startup:

The existing kernel >>
http://www-zeuthen.desy.de/~boyanov/dmesg_normal.txt<http://www-zeuthen.des=
y.de/%7Eboyanov/dmesg_normal.txt>
The new one          >>
http://www-zeuthen.desy.de/~boyanov/dmesg_failed.txt<http://www-zeuthen.des=
y.de/%7Eboyanov/dmesg_failed.txt>

As you can see in the links above the kernel panics because of insufficient
"init" part of the command line passed to it. Another issue is the SCSI
hard-disk initialization and RAM disk creation. I forgot to mention, becaus=
e
this is only a test kernel I just want basic functionality included, as I
tried to do so in the kernel configuration.
But nevertheless i failed to do so.
I'm actually only asking for some advice and tips (especially where to find
information on the web, if there is any) on the problems occuring, or if
someone has encountered such problems in the past and is willing to share
his/her experience.
I'm quite newbie to this stuff, and as such I'm really confused about what'=
s
going on...
So any help and advice is appreciated.

Best regards,
Konstantin

------=_Part_5549_15162349.1146477261375
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,<br>
<br>
These days I'm trying to compile and get working a 2.6 kernel for the
Motorola MVME6100 VME single board computer. For the purpose I'm using
an ELinOS IDE by the SysGo company (don't ask me why, it's the boss'
decision). Since ELinOS lacks support I post here with the hope of
getting some help. Thus far I have succeeded
in only compiling a bare kernel but not getting it up. There is a
running RedHat distro on the board but I want to get a customized
cernel for it, because RedHat does not support certain stuff (like VME
drivers for example).<br>
So, the kernel I compiled seems to be quite messy, as you can see from the =
dmesg at startup:<br>
<br>
The existing kernel &gt;&gt; <a href=3D"http://www-zeuthen.desy.de/%7Eboyan=
ov/dmesg_normal.txt" target=3D"_blank" onclick=3D"return top.js.OpenExtLink=
(window,event,this)">http://www-zeuthen.desy.de/~boyanov/dmesg_normal.txt</=
a>
<br>
The new one&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; =
<a href=3D"http://www-zeuthen.desy.de/%7Eboyanov/dmesg_failed.txt" target=
=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">http:/=
/www-zeuthen.desy.de/~boyanov/dmesg_failed.txt</a>
<br>
<br>
As you can see in the links above the kernel panics because of
insufficient &quot;init&quot; part of the command line passed to it. Anothe=
r
issue is the SCSI hard-disk initialization and RAM disk creation. I
forgot to mention, because this is only a test kernel I just want basic
functionality included, as I tried to do so in the kernel
configuration. <br>
But nevertheless i failed to do so.<br>
I'm actually only asking for some advice and tips (especially where to
find information on the web, if there is any) on the problems occuring,
or if someone has encountered such problems in the past and is willing
to share his/her experience.<br>
I'm quite newbie to this stuff, and as such I'm really confused about what'=
s going on...<br>
So any help and advice is appreciated.<br>
<br>
Best regards,<br>
Konstantin<br>



------=_Part_5549_15162349.1146477261375--
