Return-Path: <vinayak.kale@gmail.com>
Received: from mail-pw0-f43.google.com (mail-pw0-f43.google.com
	[209.85.160.43]) by ozlabs.org (Postfix) with ESMTP id AC6FCB7B8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 05:47:21 +1100 (EST)
Received: by pwi12 with SMTP id 12so2884667pwi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 Nov 2009 10:47:19 -0800 (PST)
MIME-Version: 1.0
From: Vinayak Kale <vinayak.kale@gmail.com>
Date: Sun, 22 Nov 2009 00:16:59 +0530
Message-ID: <5eb65910911211046q433072f1nd2a6eb955593a37a@mail.gmail.com>
Subject: DTS for PowerPC 440 based board
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=00504502f623a15f020478e605e5
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00504502f623a15f020478e605e5
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I am porting 2.6.31 for a PowerPC 440 core based board. I have couple of
queries. I would really appreciate if someone could answer since i couldn't
find info from other places.

1) Is it mandatory to create a DTS file?
2) If uboot passes BDInfo struct to kernel instead of DT blob, then in this
case does kernel creates FDT at run time?
3) I believe in case of DTS, the kernel picks up the h/w info from DTS blob
so we need not hardcode any register addresses etc inside kernel other than
in dts file. What happens in case of uboot passing just BDInfo struct. How
do we specify the register addresses etc?

Thanks
Vinayak

--00504502f623a15f020478e605e5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>I am porting 2.6.31 for a PowerPC 440 core based board. I have coupl=
e of queries. I would really appreciate if someone could answer since i cou=
ldn&#39;t find info from other places.<br><br>1) Is it mandatory to create =
a DTS file? <br>

2) If uboot passes BDInfo struct to kernel instead of DT blob, then in this=
 case does kernel creates FDT at run time? <br>3) I believe in case of DTS,=
 the kernel picks up the h/w info from DTS blob so we need not hardcode any=
 register addresses etc inside kernel other than in dts file. What happens =
in case of uboot passing just BDInfo struct. How do we specify the register=
 addresses etc?<br>

<br>Thanks<br>Vinayak<br>

--00504502f623a15f020478e605e5--
