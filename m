Return-Path: <jonsmirl@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0C9E0B7098
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 23:34:40 +1000 (EST)
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171]) by ozlabs.org (Postfix) with ESMTP id 58EA6DDD1B
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jun 2009 23:34:37 +1000 (EST)
Received: by qyk1 with SMTP id 1so3256153qyk.17
	for <linuxppc-dev@ozlabs.org>; Sat, 06 Jun 2009 06:34:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <23901807.post@talk.nabble.com>
References: <23901807.post@talk.nabble.com>
Date: Sat, 6 Jun 2009 09:34:35 -0400
Message-ID: <9e4733910906060634k16a2dc6er138820e71cd2c6cf@mail.gmail.com>
Subject: Re: Missing some interrupts
From: Jon Smirl <jonsmirl@gmail.com>
To: wael showair <showair2003@yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 6, 2009 at 9:17 AM, wael showair<showair2003@yahoo.com> wrote:
>
> Hi All,
> i have a freescale board, that contains MPC8555 processor & DSP-core
> there is a GPIO connecting the DSP-core into an input pin of the OpenPIC of
> the MPC8555 processor.
>
> i test one interrupt from the DSP-core to the MPC8555 processor where i
> configure this interrupt line to be edge-triggered (falling edge) & i
> receive it successfully
> but
> when i generate this interrupt 10 successive times using for loop
> i just receive 2 interrupts?
>
> why can't i receive the 8 other interrupts?
> i print the value of every irq number inside do_IRQ & i found that i receive
> the DSP-interrupt just only twice.
>
> do u have any suggestions to solve this problem?
> i want to make sure that i can receive 10 interrupts

Don't do a printk() with interrupts disabled. A printk() takes 1.5ms
on a mpc5200.


> --
> View this message in context: http://www.nabble.com/Missing-some-interrupts-tp23901807p23901807.html
> Sent from the linuxppc-dev mailing list archive at Nabble.com.
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



-- 
Jon Smirl
jonsmirl@gmail.com
