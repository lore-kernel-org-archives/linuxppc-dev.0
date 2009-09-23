Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221]) by ozlabs.org (Postfix) with ESMTP id 41ACCB7B72
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 16:57:47 +1000 (EST)
Received: by ewy21 with SMTP id 21so408736ewy.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 23:57:45 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Johnny Hung <johnny.hacking@gmail.com>
Subject: Re: GPIO driver for MPC8313.
References: <cb9ecdfa0909222055x1d691698sb516b5b8f5f81d@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 23 Sep 2009 08:57:43 +0200
In-Reply-To: <cb9ecdfa0909222055x1d691698sb516b5b8f5f81d@mail.gmail.com>
	(Johnny Hung's message of "Wed\, 23 Sep 2009 11\:55\:36 +0800")
Message-ID: <87y6o6rvvc.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Johnny" =3D=3D Johnny Hung <johnny.hacking@gmail.com> writes:

 Johnny> Hi All:
 Johnny> =C2=A0 =C2=A0Is there a alreday written GPIO dirver or example for
 Johnny> MPC8313/similar ppc platform. It looks like many people need GPIO
 Johnny> dirver to control LED, etc... I think is it possible to write a
 Johnny> general gpio driver for all ppc platform and only need to modify g=
pio
 Johnny> iomap information of dtb file. Please give me a advice. Thanks in
 Johnny> advanced.

Sure, it's arch/powerpc/sysdev/mpc8xxx_gpio.c, included since 2.6.28. To
use it, simply enable CONFIG_MPC8xxx_GPIO and add a gpio-controller node
to your dts, similar to how it's done in
arch/powerpc/boot/dts/mpc837*_rdb.dts.

See Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt for details of
the dts bindings.

--=20
Bye, Peter Korsgaard
