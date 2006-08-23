Return-Path: <linuxppcleo@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.238])
	by ozlabs.org (Postfix) with ESMTP id 2513167C53
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 02:46:11 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i20so68187wra
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 09:46:09 -0700 (PDT)
Message-ID: <a0bc9bf80608230946t6d248876q33d8b1ddd02e31d8@mail.gmail.com>
Date: Thu, 24 Aug 2006 00:46:09 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
Subject: Re: BogoMIPS no longer supported on PowerPC?
In-Reply-To: <44EC8338.3050203@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1156329453.3914.13.camel@ux156> <44EC8338.3050203@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/24/06, Tim Bird <tim.bird@am.sony.com> wrote:
> Johannes Berg wrote:
> > On Wed, 2006-08-23 at 18:25 +0800, Li Yang-r58472 wrote:
> >  > I noticed a recent modification to __delay has changed from using empty
> >  > loops to reading timebase.  Thus, breaks the calculation of bogomips,
> >  > and makes it terribly low.  Is the bogomips no longer being supported on
> >  > powerpc arch?
> >
> > What's there to be 'supported'? The only purpose of bogomips is
> > calibrating the delay loop, and that has changed now by using timebase,
> > hence bogomips no longer have a purpose. There was even a patch to
> > remove it from /proc/cpuinfo but I'm not sure whether that got applied
> > or not.
>
> I missed the patch for this, but I have a related question.
> What is the status of the calibration code now for PPC?
> Is it just skipped?


The calibration is still used.

>
> I assume that the ability to set a preset loops_per_jiffy
> is no longer relevant?

However, loop is no longer true loop now.  It should be called
timebase_change_per_jiffy. :)

- Leo
