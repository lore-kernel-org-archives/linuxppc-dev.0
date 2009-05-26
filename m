Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f196.google.com (mail-qy0-f196.google.com
	[209.85.221.196]) by ozlabs.org (Postfix) with ESMTP id 869D1DDFCF
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 23:12:12 +1000 (EST)
Received: by qyk34 with SMTP id 34so6246838qyk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 06:12:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090526130301.GE8969@sirena.org.uk>
References: <20090526123235.17472.73912.stgit@terra>
	<20090526123406.17472.79948.stgit@terra>
	<20090526130301.GE8969@sirena.org.uk>
Date: Tue, 26 May 2009 09:12:10 -0400
Message-ID: <9e4733910905260612v40a70ad8haeb4c916a1a758b5@mail.gmail.com>
Subject: Re: [PATCH V5 1/5] powerpc: introduce macro spin_event_timeout()
From: Jon Smirl <jonsmirl@gmail.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 9:03 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, May 26, 2009 at 08:34:06AM -0400, Jon Smirl wrote:
>> The macro spin_event_timeout() takes a condition and timeout value
>> (in microseconds) as parameters. =A0It spins until either the condition =
is true
>> or the timeout expires. =A0It returns the result of the condition when t=
he loop
>> was terminated.
>
> As previously mentioned you need to submit any changes you want to make
> here as incremental patches against the PowerPC tree rather than as an
> entire new patch. =A0If you are forwarding on copies of the patch you
> really ought to preserve Timur's authorship too with a From line in the
> mail.

I have reverted back to TImur's original patch  so you can just drop
this patch if that is easier for you.
You'll just need to coordinate the landing so that things land in the
right order.

--=20
Jon Smirl
jonsmirl@gmail.com
