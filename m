Return-Path: <dceravigupta@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id 06580B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 00:19:42 +1000 (EST)
Received: by pwi4 with SMTP id 4so59018pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Aug 2010 07:19:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinYCfFJB2NR3hcQ4aZU7QXfCs2ixdEu7VuNxf0=@mail.gmail.com>
References: <AANLkTinYCfFJB2NR3hcQ4aZU7QXfCs2ixdEu7VuNxf0=@mail.gmail.com>
Date: Wed, 11 Aug 2010 19:49:40 +0530
Message-ID: <AANLkTimJ1+d7U2SN_SSHepo6u01RJqUEXUDQXUgBfCWK@mail.gmail.com>
Subject: Re: How to use mpc8xxx_gpio.c device driver
From: Ravi Gupta <dceravigupta@gmail.com>
To: linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016e64cb288ba0ffc048d8cf013
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e64cb288ba0ffc048d8cf013
Content-Type: text/plain; charset=ISO-8859-1

Also, when I try to export a gpio in sysfs

echo 9 > /sys/class/gpio/export

It gives me an error in dmesg
gpio_request: gpio-9 (sysfs) status -22
export_store: status -22

Here is a look of sysfs on my machine

# ls /sys/class/gpio/ -la
drwxr-xr-x    4 root     root            0 Jan  1 00:00 .
drwxr-xr-x   24 root     root            0 Jan  1 00:00 ..
--w-------    1 root     root         4096 Jan  1 00:10 export
drwxr-xr-x    3 root     root            0 Jan  1 00:00 gpiochip192
drwxr-xr-x    3 root     root            0 Jan  1 00:00 gpiochip224
--w-------    1 root     root         4096 Jan  1 00:00 unexport

--0016e64cb288ba0ffc048d8cf013
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Also, when I try to export a gpio in sysfs<br><br>echo 9 &gt; /sys/class/gp=
io/export<br><br>It gives me an error in dmesg<br>gpio_request: gpio-9 (sys=
fs) status -22<br>export_store: status -22<br><br>Here is a look of sysfs o=
n my machine<br>
<br># ls /sys/class/gpio/ -la<br>drwxr-xr-x=A0=A0=A0 4 root=A0=A0=A0=A0 roo=
t=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 Jan=A0 1 00:00 .<br>drwxr-xr-x=A0=A0 2=
4 root=A0=A0=A0=A0 root=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 Jan=A0 1 00:00 .=
.<br>--w-------=A0=A0=A0 1 root=A0=A0=A0=A0 root=A0=A0=A0=A0=A0=A0=A0=A0 40=
96 Jan=A0 1 00:10 export<br>
drwxr-xr-x=A0=A0=A0 3 root=A0=A0=A0=A0 root=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0 Jan=A0 1 00:00 gpiochip192<br>drwxr-xr-x=A0=A0=A0 3 root=A0=A0=A0=A0 =
root=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 Jan=A0 1 00:00 gpiochip224<br>--w--=
-----=A0=A0=A0 1 root=A0=A0=A0=A0 root=A0=A0=A0=A0=A0=A0=A0=A0 4096 Jan=A0 =
1 00:00 unexport<br><br><br>

--0016e64cb288ba0ffc048d8cf013--
