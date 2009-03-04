Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 23793DDF11
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 11:16:00 +1100 (EST)
Received: by gxk1 with SMTP id 1so10043420gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Mar 2009 16:15:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090303160906.9b30b376.akpm@linux-foundation.org>
References: <20090303160906.9b30b376.akpm@linux-foundation.org>
Date: Tue, 3 Mar 2009 17:15:58 -0700
Message-ID: <fa686aa40903031615wa3e9c3bt226636f5b51d293c@mail.gmail.com>
Subject: Re: "leds: Add openfirmware platform device support" breaks sparc
From: Grant Likely <grant.likely@secretlab.ca>
To: Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@linux.intel.com>,
	Trent Piepho <tpiepho@freescale.com>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 3, 2009 at 5:09 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> linux-next's dc0f6e94d7f487c624254597a0b86ef41c525673 (which I don't
> seem to be able to find on any mailing lists to which I subscribe)
> breaks the sparc64 allmodconfig build:

Hmm, I don't see that one either.  Which tree did it go in via?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
