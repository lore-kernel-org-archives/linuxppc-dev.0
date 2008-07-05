Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 440D6DDEFD
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jul 2008 04:52:59 +1000 (EST)
Date: Sat, 5 Jul 2008 12:52:53 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Vegard Nossum <vegard.nossum@gmail.com>
Subject: Re: the printk problem
Message-ID: <20080705185253.GQ14894@parisc-linux.org>
References: <20080705125230.GA20166@damson.getinternet.no>
	<alpine.LFD.1.10.0807051045520.2815@woody.linux-foundation.org>
	<19f34abd0807051141h4ccfd0ar28660199f2bbf81f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19f34abd0807051141h4ccfd0ar28660199f2bbf81f@mail.gmail.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Engelhardt <jengelh@medozas.de>, linuxppc-dev@ozlabs.org,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 05, 2008 at 08:41:39PM +0200, Vegard Nossum wrote:
> Single letters are bad because it hurts readability and limits the
> usefulness of the extension.</MHO>

I think you need a little warning noise that goes off in your head that
means "I might be overdesigning this".  Linus' code is elegant and
solves a problem nicely.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
