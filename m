Return-Path: <dceravigupta@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by ozlabs.org (Postfix) with ESMTP id 4C15DB70DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Aug 2010 19:39:58 +1000 (EST)
Received: by pzk5 with SMTP id 5so696898pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Aug 2010 02:39:56 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 15:09:56 +0530
Message-ID: <AANLkTiktTpduot+GJNmqRWPoXWbFnTbN=3pN8vvDU6FE@mail.gmail.com>
Subject: SPI bitbanging driver
From: Ravi Gupta <dceravigupta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, MJ embd <mj.embd@gmail.com>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>,
	Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: multipart/alternative; boundary=0016364582baf3fb10048eb6c74d
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016364582baf3fb10048eb6c74d
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am new to linux device driver development. I have to develop a spi
bitbanging driver for MPC837xERDB board. So far I have found that linux
kernel already has support for bitbanging over gpio(I am using linux kernel
2.6.35). Now I am confused that how I am going to configure SPI pins as GPIO
and what API to use to write my driver. I searched over internet a lot for a
sample SPI bitbang driver but unable to do so. Can anyone provide me some
sample bitbang driver explaning how to use the spi_bitbang.c and spi_gpio.c.
Do I need to change the mpc8377_rdb.dts file to register spi pins as gpio?

Thanks in advance
Ravi Gupta

--0016364582baf3fb10048eb6c74d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am new to linux device driver development. I have to develop a=
 spi bitbanging driver for MPC837xERDB board. So far I have found that linu=
x kernel already has support for bitbanging over gpio(I am using linux kern=
el 2.6.35). Now I am confused that how I am going to configure SPI pins as =
GPIO and what API to use to write my driver. I searched over internet a lot=
 for a sample SPI bitbang driver but unable to do so. Can anyone provide me=
 some sample bitbang driver explaning how to use the spi_bitbang.c and spi_=
gpio.c. Do I need to change the mpc8377_rdb.dts file to register spi pins a=
s gpio?<br>
<br>Thanks in advance <br>Ravi Gupta<br>

--0016364582baf3fb10048eb6c74d--
