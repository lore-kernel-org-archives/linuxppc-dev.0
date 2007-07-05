Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DE826DDEDA
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 05:16:22 +1000 (EST)
Date: Thu, 5 Jul 2007 12:54:06 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH]: PCI Error Recovery: Symbios SCSI device driver
Message-ID: <20070705185406.GA3527@parisc-linux.org>
References: <20070702183917.GJ4501@austin.ibm.com>
	<20070705112838.2d8c959b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070705112838.2d8c959b.akpm@linux-foundation.org>
Cc: James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org, willy@debian.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 05, 2007 at 11:28:38AM -0700, Andrew Morton wrote:
> Well you've sent it a couple of times, and I've sent it in five more times
> over the past year.  Once we were told "awaiting maintainer ack".
> 
> This situation is fairly stupid.  How about we make you the maintainer?

Last time I looked at it, I still wasn't comfortable with it.  I'm going
to look at it again.

I'm fairly sure Linas doesn't want to be the sym2 maintainer.  It's
still an ugly pile of junk that needs cleaning up.

-- 
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
