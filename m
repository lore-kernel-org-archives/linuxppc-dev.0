Return-Path: <julian.calaby@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.224])
	by ozlabs.org (Postfix) with ESMTP id 06506DDF11
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 11:40:52 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so2917367rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Mar 2009 16:40:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090303192932.31705cf7@lappy.seanm.ca>
References: <20090303160906.9b30b376.akpm@linux-foundation.org>
	<20090303192932.31705cf7@lappy.seanm.ca>
Date: Wed, 4 Mar 2009 11:40:50 +1100
Message-ID: <646765f40903031640x39b3361fic8833a4bf15b1381@mail.gmail.com>
Subject: Re: "leds: Add openfirmware platform device support" breaks sparc
From: Julian Calaby <julian.calaby@gmail.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@linux.intel.com>,
	sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 4, 2009 at 11:29, Sean MacLennan <smaclennan@pikatech.com> wrote:
> On Tue, 3 Mar 2009 16:09:06 -0800
> "Andrew Morton" <akpm@linux-foundation.org> wrote:
>
>> afacit that interface is powerpc-only.
>
> Yes it is. You might want a CONFIG_PPC with that.
>
> It has been..... uhhhh carry the two... longer than I want to admit
> since I worked on a sparc. Would GPIO based LEDS make sense on a sparc
> platform? Is sparc used much in the embedded world?
>
> If yes, the of_register_platform_driver is just a nice wrapper. It
> would be trivial to either change it to work on sparc, or add the
> wrapper to the sparc includes.

These inconsistencies are causing more problems with PPC drivers
depending on the generic infrastructure.

See: http://lkml.org/lkml/2009/1/11/376 for a similar issue.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
