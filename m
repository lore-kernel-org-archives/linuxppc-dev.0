Return-Path: <>
Received: from nullcode.org (nullcode.org [69.56.173.217])
	by ozlabs.org (Postfix) with ESMTP id 73B302BEA0
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 13:11:33 +1100 (EST)
Date: Mon, 22 Nov 2004 20:40:06 -0500
From: Chris Anderson <chris@nullcode.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041123014006.GA18931@nullcode.org>
References: <1100847411.25521.42.camel@gaston> <1100852423.3855.2.camel@gaston>
	<1101083578.13597.5.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1101083578.13597.5.camel@gaston>
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

On Mon, Nov 22, 2004 at 11:32:58AM +1100, Benjamin Herrenschmidt wrote:
> Ok, here's the 4th iteration of the patch. It includes John Steele Scott fixes for
> cpufreq and the sound driver and fixes a problem where memory refresh wouldn't properly
> be re-enabled on the video chip upon wakeup. I also cleaned a bit more the MDLL reset
> code for r300, plus a couple of other things.
> 
> http://gate.crashing.org/~benh/albook-ibookg4-sleep-4.diff
> 
> Ben.

Works like a charm here.

> 
> 
> 
> -- 
> To UNSUBSCRIBE, email to debian-powerpc-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
> 

-- 
Chris Anderson <chris@nullcode.org>
ICQ: 72021847  Jabber: chrisja@jabber.org
20B2 CB34 8AA5 05BC A90C  2CDD 2768 D4B4 2B93 424B
