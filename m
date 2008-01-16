Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 2515EDDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jan 2008 07:30:54 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so89693anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 12:30:51 -0800 (PST)
Message-ID: <fa686aa40801161230q2308188djf1f6c756412051dc@mail.gmail.com>
Date: Wed, 16 Jan 2008 13:30:49 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Joachim Meyer" <Jogi95@web.de>
Subject: Re: ml310 kernel2.6 booting problems
In-Reply-To: <538215286@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <538215286@web.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/16/08, Joachim Meyer <Jogi95@web.de> wrote:
> Thx for the answer
>
> It's right, there is no /dev/console, but the MontaVista-Linux-kernel can fully boot with this rootFS, how comes?

hmmm, I don't know.  The montavista kernel might be running a
different binary as the init process.  Compare the kernel parameter
lines between the two.

> Doesn't matter, I was going to make my own RootFS anyway, so can you give me an hint how I would
> do this best?
> I tried the Klingauf-Script (www.klingauf.com) with busybox, but I still have no console in my /dev/ and it doesn't work.

Creating a console device is easy:

$ mknod /dev/console c 5 1

> I tried out buildroot, but I was a little overstrained with the configuration and when I did "make" it aborted with an error message
> after a long time of working
> Then I tried ELDK. I read that I could use the Directory "<install-dir>/ppc_4xx/" as rootfs but when I go there and look inside
> /dev I find only one entry:
> prw------- 1 jogi jogi 0 2007-01-20 04:58 initctl
> So this won't work, would it?

Looks like you haven't installed ELDK correctly.  I recommend
rereading the instructions and giving it another try.  ELDK is a great
starting point.

>
> Which way would be the best for me to get an good RootFS easily?
> If the answer would be buildroot can you give me a short summary which settings are importent?

Personally, I use buildroot, but you should start with ELDK to get things going.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
