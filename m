Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AF782DDF26
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 11:28:10 +1100 (EST)
Date: Tue, 3 Mar 2009 16:28:02 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: "leds: Add openfirmware platform device support" breaks sparc
Message-Id: <20090303162802.abadba4a.akpm@linux-foundation.org>
In-Reply-To: <fa686aa40903031615wa3e9c3bt226636f5b51d293c@mail.gmail.com>
References: <20090303160906.9b30b376.akpm@linux-foundation.org>
	<fa686aa40903031615wa3e9c3bt226636f5b51d293c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	rpurdie@linux.intel.com, tpiepho@freescale.com, smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Mar 2009 17:15:58 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Tue, Mar 3, 2009 at 5:09 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > linux-next's dc0f6e94d7f487c624254597a0b86ef41c525673 (which I don't
> > seem to be able to find on any mailing lists to which I subscribe)
> > breaks the sparc64 allmodconfig build:
> 
> Hmm, I don't see that one either.  Which tree did it go in via?
> 

leds            git     git://git.o-hand.com/linux-rpurdie-leds#for-mm
