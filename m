Return-Path: <nix.or.die@googlemail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.191])
	by ozlabs.org (Postfix) with ESMTP id AA7DADDDE6
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 19:38:32 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so162042mue
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Aug 2007 02:38:31 -0700 (PDT)
Message-ID: <46B05484.8080701@googlemail.com>
Date: Wed, 01 Aug 2007 11:38:12 +0200
From: Gabriel C <nix.or.die@googlemail.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] Typo fixes interrrupt -> interrupt
References: <46AFFB0B.102@googlemail.com>
	<20070801144318.f81fd988.sfr@canb.auug.org.au>
In-Reply-To: <20070801144318.f81fd988.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> On Wed, 01 Aug 2007 05:16:27 +0200 Gabriel C <nix.or.die@googlemail.com> wrote:
>>  arch/powerpc/platforms/iseries/it_lp_naca.h       |   87 +++++++++++----------
> 
> NAK this part as it just makes a lot of the lines more than 80 characters
> for no real gain on a platform that is moving on ...

Well some were there before but with the wrong comment style.

I'll send an new patch in a bit without the comments fixes.


Gabriel
