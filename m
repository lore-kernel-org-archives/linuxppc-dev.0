Return-Path: <solyn123@gmail.com>
Received: from mail-pz0-f172.google.com (mail-pz0-f172.google.com
	[209.85.222.172]) by ozlabs.org (Postfix) with ESMTP id ECA46B7BE2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Dec 2009 14:53:24 +1100 (EST)
Received: by pzk2 with SMTP id 2so3699653pzk.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 06 Dec 2009 19:53:23 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 7 Dec 2009 11:53:22 +0800
Message-ID: <8148211e0912061953n59dfbe4fsea033494ad8b6fcc@mail.gmail.com>
Subject: Ping does not work on my MPC8544 board, using linux2.6.23
From: =?GB2312?B?wdbWvsa9?= <solyn123@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=00504502cb1b201f20047a1b6636
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00504502cb1b201f20047a1b6636
Content-Type: text/plain; charset=ISO-8859-1

Hi,all:
This is my first time to post on this maillist,I got a problem that ping can
not work and I am wondering if it is because of my mismatch of linux kernel
and DTC compiler version.
I am using mpc8544ds_bsp provided by freescale.
I used uboot2009.08 to boot my board successfully.
At first, I using the dtc compiler in this bsp which is version 1.1.0 along
with linux2.6.23 which is also provided by this bsp.
But I failded to boot the linux kernel.
And later, I tried out using dtc1.2.0 and the mpc8544ds.dts in linux-2.6.23,
there are some systax errors like hex to dec. And I modified the
mpc8544ds.dts to to fit dtc1.2.0.
And I boot linux successfully, but PING doesnot work now.
I am sure I set the ipaddr netmask ,and  default gateway correctly.
Does dtc1.2.0 can compile dts files under linux2.6.23?
Another question is that I found linux2.6.31 does not support
board mpc8544ds, And I never boot linux-2.6.31 on my board, why linux-2.6.31
doesnot provide a config file like mpc8544_ds_defconfig?
Thanks!

--00504502cb1b201f20047a1b6636
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,all:</div>
<div>This is my first time to post on this maillist,I got a problem that pi=
ng can not work and I am wondering if it is because of my mismatch of linux=
 kernel and DTC compiler version.</div>
<div>I am using mpc8544ds_bsp provided by freescale.</div>
<div>I used uboot2009.08 to boot my board successfully.</div>
<div>At first, I using the dtc compiler in this bsp which is version 1.1.0 =
along with linux2.6.23 which is also provided by this bsp.</div>
<div>But I failded to boot the linux kernel.</div>
<div>And later, I tried out using dtc1.2.0 and the mpc8544ds.dts in linux-2=
.6.23, there are some systax errors like hex to dec. And I modified the mpc=
8544ds.dts to to fit dtc1.2.0.</div>
<div>And I boot linux successfully, but PING doesnot work now.</div>
<div>I am sure I set the ipaddr netmask ,and=A0 default gateway correctly.<=
/div>
<div>Does dtc1.2.0 can compile dts files under linux2.6.23?</div>
<div>Another question is that I found linux2.6.31 does not support board=A0=
mpc8544ds, And I never boot linux-2.6.31 on my board, why linux-2.6.31 does=
not provide a config file like mpc8544_ds_defconfig?</div>
<div>Thanks!</div>

--00504502cb1b201f20047a1b6636--
