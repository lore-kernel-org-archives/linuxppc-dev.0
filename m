Return-Path: <netstv@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 26F12679F2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 23:57:43 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id e30so2070102pya
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 06:57:41 -0700 (PDT)
Message-ID: <b4b98b690605100657n1d54fcdw51bb5bdc77f9813a@mail.gmail.com>
Date: Wed, 10 May 2006 06:57:26 -0700
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Kernel panic - not syncing: No init found.
In-Reply-To: <-1484187685935794069@unknownmsgid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <-1484187685935794069@unknownmsgid>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/10/06, hangtoo <hangtoo@163.com> wrote:
>
> I try to make a new uRamdisk for my bubinga board(linux-2.6.14,PPC405EP).
> actully I just copy the most of the files in the board,and compiled busyb=
ox with ppc tools.
> but when I use the new uRamdisk for a try,it just showed up this errors(a=
s follow),then reboot,back and forth...
> **************************************************
> RAMDISK: incomplete write (-28 !=3D 32768) 4194304
>


I'm pretty sure this tells me that your ramdisk is not big enough.
Take a look at
http://www.vanemery.com/Linux/Ramdisk/ramdisk.html

If you are using LILO like in the example listed at the link above,
you need to make sure your ramdisk_size parameter is big enough.

That's what my gues is.

-stv
