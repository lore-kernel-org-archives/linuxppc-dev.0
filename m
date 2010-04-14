Return-Path: <terren.chow@gmail.com>
Received: from mail-pz0-f195.google.com (mail-pz0-f195.google.com
	[209.85.222.195]) by ozlabs.org (Postfix) with ESMTP id D72FFB7D48
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 04:10:01 +1000 (EST)
Received: by pzk33 with SMTP id 33so385046pzk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Apr 2010 11:08:27 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 15 Apr 2010 02:08:27 +0800
Message-ID: <u2w9faa26521004141108vf9f06e06j15e864ea94fff3e8@mail.gmail.com>
Subject: Re:mpc5121e-Real Time Clock
From: Terren Chow <terren.chow@gmail.com>
To: moises.dominguez@ctag.com
Content-Type: multipart/alternative; boundary=000e0cd13842cfefea04843643db
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd13842cfefea04843643db
Content-Type: text/plain; charset=ISO-8859-1

I don't think the internal RTC is workable. I've read the RTC section in the
MPC5121 data sheet, and I found that the RTC only keep the time tick
register using VBAT. So if there is a power failure, the RTC will lost its
minute and hour information. After the system boot up, the kernel will read
the RTC to get its wall time, so the system time will reset to 1970xxxxx. I
think there is a design mistake of the CPU.
The only solution is using the mt41 RTC chip on the ADS5121 board as the RTC
device.

-- 
Terren Chow
Graduate student
College of Informatics, SCAU
MSN: terren.chow@hotmail.com

--000e0cd13842cfefea04843643db
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I don&#39;t think the internal RTC is workable. I&#39;ve read the RTC secti=
on in the MPC5121 data sheet, and I found that the RTC only keep the time t=
ick register using VBAT. So if there is a power failure, the RTC will lost =
its minute and hour information. After the system boot up, the kernel will =
read the RTC to get its wall time, so the system time will reset to 1970xxx=
xx. I think there is a design mistake of the CPU.<br>
The only solution is using the mt41 RTC chip on the ADS5121 board as the RT=
C device.=A0 <br clear=3D"all"><br>-- <br>Terren Chow<br>Graduate student<b=
r>College of Informatics, SCAU<br>MSN: <a href=3D"mailto:terren.chow@hotmai=
l.com">terren.chow@hotmail.com</a><br>
<br>

--000e0cd13842cfefea04843643db--
