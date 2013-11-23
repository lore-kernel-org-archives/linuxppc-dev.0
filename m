Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3BD5E2C0141
 for <linuxppc-dev@ozlabs.org>; Sun, 24 Nov 2013 08:19:00 +1100 (EST)
Message-ID: <1385241533.4882.137.camel@pasglop>
Subject: Re: Windfarm's max6690 sensor driver was not included in makefile
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stanislav Ponomarev <devhexorg@gmail.com>
Date: Sun, 24 Nov 2013 08:18:53 +1100
In-Reply-To: <CA+2fWjZRw7zdCACXXSTPN4QVeuXN5CLOZSOJJiGuP4UBcS2aMA@mail.gmail.com>
References: <CA+2fWjZRw7zdCACXXSTPN4QVeuXN5CLOZSOJJiGuP4UBcS2aMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-11-22 at 15:09 -0600, Stanislav Ponomarev wrote:
> Hello, I had problems with fan speed in my XServe G5. It turned out
> drivers/macintosh/Makefile has a max6690 module missing from
> compilation list. I was advised to mail the patch to you guys.
> 
> 
> I'm not sure what's the proper format of the patch to be submitten
> (this is my first time). So I'm including it into the message body,
> and as an attached file.

So make sure you send it as plain text in a form that preserves tabs and
space (I don't now if gmail allows that). Also please include a
"Signed-off-by:" line.

Cheers,
Ben.

> diff --git a/drivers/macintosh/Makefile b/drivers/macintosh/Makefile
> index 6753b65..d2f0120 100644
> --- a/drivers/macintosh/Makefile
> +++ b/drivers/macintosh/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_WINDFARM_RM31)     +=
> windfarm_fcu_controls.o \
>                                    windfarm_ad7417_sensor.o \
>                                    windfarm_lm75_sensor.o \
>                                    windfarm_lm87_sensor.o \
> +                                  windfarm_max6690_sensor.o \
>                                    windfarm_pid.o \
>                                    windfarm_cpufreq_clamp.o \
>                                    windfarm_rm31.o
> 
> 
> 
> Thank you.
> 
> Stanislav Ponomarev.
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
