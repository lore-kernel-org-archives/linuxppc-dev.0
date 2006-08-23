Return-Path: <linuxppcleo@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.232])
	by ozlabs.org (Postfix) with ESMTP id BA2A667BEB
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 02:47:43 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i20so68517wra
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 09:47:41 -0700 (PDT)
Message-ID: <a0bc9bf80608230947q6d5e0dccw12a12fcbc9d8c76@mail.gmail.com>
Date: Thu, 24 Aug 2006 00:47:41 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
Subject: Re: BogoMIPS no longer supported on PowerPC?
In-Reply-To: <20060823145138.GH614@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1156329453.3914.13.camel@ux156>
	<4879B0C6C249214CBE7AB04453F84E4D0FC20C@zch01exm20.fsl.freescale.net>
	<20060823145138.GH614@pb15.lixom.net>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/23/06, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Aug 23, 2006 at 06:55:26PM +0800, Li Yang-r58472 wrote:
> > Ok, I rephrase my question as is it no longer needed?  Sometimes people
> > may use this value as a rough estimation of CPU performance.  There are
> > people even maintained a list of bogoMIPS of most CPUs.  Maybe it is
> > still needed for some legacy reasons.  I'm not very sure.  :)   At leave
> > we need to inform people who do look at this magic number and find it
> > amazingly low.
>
> Bogomips has never had anything to do with performance on PPC, it's just
> a number that's based on the decrementer frequency. For processors with
> external/fixed decrementer clock, it will not vary between different
> processors in a meaningful way.
>
> Every now and then someone will ask "why does my PPC box have such low
> bogomips, is it really that much slower than my PC?". Removing all output
> would certainly help avoid that confusion.
>
> For reference, my G5 here has 66.56 bogomips, which corresponds well to
> the 33MHz decrementer clock it uses.


I think it's the new way to use timebase or RTC.  Legacy bogomips is
calculated by counting empty loops, which at some degree reflects cpu
performance.  Do you mean it has always been like this for PPC?

- Leo
