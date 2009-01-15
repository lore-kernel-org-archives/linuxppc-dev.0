Return-Path: <neko@genesi-usa.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 53292DE287
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 12:30:14 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so353978yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 17:30:12 -0800 (PST)
Sender: Matt Sealey <neko@genesi-usa.com>
Message-ID: <496E91A4.7030406@genesi-usa.com>
Date: Wed, 14 Jan 2009 19:30:12 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Stefan Strobl <nst@gersys.de>
Subject: Re: ADS5121 how to use /dev/ttyPSC
References: <496E172D.9060304@gersys.de>
In-Reply-To: <496E172D.9060304@gersys.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Strobl wrote:
> Hi
> 
> I'm new to Kernel 2.6 and OF.
> 
> I'm using a ADS5121 board with kernel from denx (ads5121 branch from
> linux-2.6-denx). According to my dts file both PSC3 and PSC4 should be
> accessible through /dev/ttyPSC0 and /dev/ttyPSC1 respectively.
> 
> When I simply try to run: "$ echo "Hello" > /dev/ttyPSC*" I can't see
> any data coming out from the ports.

Are you sending it to just one of them at a time and just abbreviating 
your mail here to include both with a *, or are you really putting that 
asterisk in there when you test?

> And when trying to initialize the ports using termios commands I'm
> getting the Error "Inappropriate ioctl for device".

You're doing this manually or with an application?

> But I can see the driver ttyPSC with major 204 in /proc/devices and I
> can also open the device successfully. I am also able to configure
> either port as CONSOLE in U-Boot so the Hardware is ok.

So you're getting debug output (udbg type stuff) on them?

-- Matt Sealey
