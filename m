Return-Path: <rider4ever@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 89463DDF63
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 00:28:17 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so41660ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 07:28:11 -0700 (PDT)
Message-ID: <ed84ed090805220728r3dc3c248l196b6e0298e78b70@mail.gmail.com>
Date: Thu, 22 May 2008 16:28:11 +0200
From: Fabri <rider4ever@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: MPC5200b MMC over SPI into PSC6
In-Reply-To: <fa686aa40805090820s66801309j161adfcbc360fc42@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <481F4DFD.1000702@libero.it> <4821A551.3060205@libero.it>
	<fa686aa40805070934t77f8b2b0y2799814b4f131bc8@mail.gmail.com>
	<482317E2.7000308@libero.it>
	<fa686aa40805080832l2492c46l400986472e985d9a@mail.gmail.com>
	<ed84ed090805090640w11dcfc57r1303ac4fceb482cb@mail.gmail.com>
	<ed84ed090805090651g65ab474fk13d549e7166c3f1c@mail.gmail.com>
	<fa686aa40805090706q572b44e9n2b39a6808562b2ad@mail.gmail.com>
	<ed84ed090805090802s177f9d47r4be59b5a47138d2a@mail.gmail.com>
	<fa686aa40805090820s66801309j161adfcbc360fc42@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Fabio Tosetto <tosettofabio83@libero.it>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Doesn't look like you are passing a kernel parameters line.  The
> kernel probably is booting, but doesn't know where to output the
> console.  Try adding "console=ttyPSC0,115200".

Hi Grant,
I've tried to add that with this commands

=> bootargs debug console=ttyPSC0,115200 root=/dev/ram
=> saveenv

but the result is not so different. It still stops after printing these lines

>Linux/PowerPC load: debug console=ttyPSC0,115200 root=/dev/ram
>Finalizing device tree... flat tree at 0x75e300

What should I see after that, in case of successful boot?
Thanks for your help.
