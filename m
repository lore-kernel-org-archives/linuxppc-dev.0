Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 2D302B7B93
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Dec 2009 07:05:44 +1100 (EST)
To: Cristian Axenie <cristian.axenie@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC5121ADS PowerVR MBX driver on 2.6.31 kernel?
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <9c789a000912021004l5dda0ee8r77a21764e035ff35@mail.gmail.com>
References: <9c789a000912021004l5dda0ee8r77a21764e035ff35@mail.gmail.com>
Date: Wed, 02 Dec 2009 21:05:42 +0100
Message-Id: <20091202200542.195F54C025@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Cristian Axenie,

In message <9c789a000912021004l5dda0ee8r77a21764e035ff35@mail.gmail.com> you wrote:
>
> I would like to know if there is someone that tested the MBX driver for the
> PowerVR graphic chip in MPC5121 ?
> It seems that on kernel 2.6.21 works fine but it fails on 2.6.31 !

You probably have to rebuild it from the source code for this new
kernel version.

> I'm using wrlinux as the build environment !

Maybe you ask WRS to provide matching binaries, then? [Note that
woever provides the binaries also has to provide the sources; the
kernel is GPL after all...]

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If the car industry behaved like the computer industry over the  last
30  years, a Rolls-Royce would cost $5, get 300 miles per gallon, and
blow up once a year killing all passengers inside.
