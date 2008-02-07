Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 85223DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 16:09:45 +1100 (EST)
Date: Thu, 7 Feb 2008 16:07:44 +1100
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: asm-offsets.c
Message-ID: <20080207050744.GE6887@bakeyournoodle.com>
References: <47AA8C7D.3030109@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <47AA8C7D.3030109@pikatech.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 06, 2008 at 11:43:41PM -0500, Sean MacLennan wrote:
> I just did a git pull of Josh's tree, and 
> arch/powerpc/kernel/asm-offsets.c does not compile. I have only been 
> glossing over the linuxppc-dev emails, so forgive me if this already 
> came up.

Hmm very sorry guys.  I /did/ build and boot pmac32_defconfig.  I have
no idea how that worked.
 
> It looks like, at least for the Warp, CLOCK_REALTIME_RES is not defined 
> so asm-offsets.c gets an error. The following patch fixes it.... but I 
> am not sure it is right since I don't know if CLOCK_REALTIME_RES should 
> be defined.

Yeah it's needed, so this patch isn;t the best solution.  I'll fix this
ASAP.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
