Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6648ADDF1E
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 02:37:48 +1100 (EST)
Date: Wed, 11 Mar 2009 08:36:04 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
In-Reply-To: <1236769025.7086.46.camel@pasglop>
Message-ID: <alpine.LFD.2.00.0903110835020.32478@localhost.localdomain>
References: <1236729444.7086.24.camel@pasglop>
	<alpine.LRH.2.00.0903111028480.1040@vixen.sonytel.be>
	<1236769025.7086.46.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 11 Mar 2009, Benjamin Herrenschmidt wrote:
> 
> I'd like to have Andrew or Linus opinion on doing this driver swap that
> late in the process.

Quite franklly, no. 

If it was a totally _new_ driver, there's no chance of regression, which 
is why we allow those drivers.

But switching an old one for a new one does not match that pattern. We can 
clearly get regressions. As such, we don't do it late in the -rc series.

		Linus
