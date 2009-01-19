Return-Path: <daniel.ng1234@gmail.com>
Received: from mail-gx0-f25.google.com (mail-gx0-f25.google.com
	[209.85.217.25]) by ozlabs.org (Postfix) with ESMTP id 6970BDDF53
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 12:58:43 +1100 (EST)
Received: by gxk6 with SMTP id 6so812680gxk.9
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jan 2009 17:58:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090116181405.GB722@ld0162-tx32.am.freescale.net>
References: <547eba1b0901151722p4a6afce4nc769fcb8cff82ea6@mail.gmail.com>
	<547eba1b0901151940x588ead2bk52342ea1cecc6db0@mail.gmail.com>
	<20090116181405.GB722@ld0162-tx32.am.freescale.net>
Date: Mon, 19 Jan 2009 12:58:41 +1100
Message-ID: <547eba1b0901181758q27d09f1fx7d07d7385f028312@mail.gmail.com>
Subject: Re: Device Tree setup for 8272-based board
From: Daniel Ng <daniel.ng1234@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,
On Sat, Jan 17, 2009 at 5:14 AM, Scott Wood <scottwood@freescale.com> wrote:
>
>> /dts-v1/;
>>
>> / {
>> model = "HPXRED";
>> compatible = "fsl,mpc8272ads";
>
> Is it 100% compatible?  If not, change the compatible to something else
> (and make sure your board code matches it).

My board is similar to the mpc8272ads, so it is not 100% compatible. So I guess
I will have to define my own DTS, correct?

How would I be able to tell if I need my own cuboot-*.c file as well?

>
> Do you currently have mpc8272ads support enabled in the kernel?  If the
> kernel doesn't find a matching ppc_md, you won't get any debug output.

No, since it is not an mpc8272ads board. What exactly are we matching here?
Is it just the Platform Name in the .config file eg. CONFIG_MPC8272_ADS?
If I use [compatible = "fsl,hpxred";] this doesn't seem to make a difference
in the behaviour.

Is the ppc_md generated from the Device Tree? Can you please point me to
the relevant file/s to see how this is done?

Also, which kernel file deals with searching for/reading the ppc_md?

>
> You can use udbg_printf() directly after the call to udbg_early_init()
> though.

Would I use these in cuboot-*.c? If so, how? Including <asm/udbg.h>
results in a 'file not found' compile error- I notice all the #includes
in the cuboot-*.c files are of the form #include "blah.h" rather than
#include <blah.h>

Overall, I just want to get my board up and running via the cuboot method.
Hopefully I'm asking the right questions! Is there anything else I might
need to know?

Thanks again for your continuing assistance.

Daniel
