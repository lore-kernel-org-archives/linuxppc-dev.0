Return-Path: <sneakums@zork.net>
Received: from zork.zork.net (zork.zork.net [64.81.246.102])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5657C2BDF2
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 00:29:54 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1100847411.25521.42.camel@gaston>
	<1100852423.3855.2.camel@gaston> <1101083578.13597.5.camel@gaston>
From: Sean Neakums <sneakums@zork.net>
Date: Mon, 22 Nov 2004 13:29:44 +0000
In-Reply-To: <1101083578.13597.5.camel@gaston> (Benjamin Herrenschmidt's
	message of "Mon, 22 Nov 2004 11:32:58 +1100")
Message-ID: <6ullcuggfr.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, gentoo-ppc-user@gentoo.org,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: TEST: Sleep patch #4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Ok, here's the 4th iteration of the patch. It includes John Steele
> Scott fixes for cpufreq and the sound driver and fixes a problem
> where memory refresh wouldn't properly be re-enabled on the video
> chip upon wakeup. I also cleaned a bit more the MDLL reset code for
> r300, plus a couple of other things.
>
> http://gate.crashing.org/~benh/albook-ibookg4-sleep-4.diff

Works great now (15" 1.5GHz PB).

Many thanks!
