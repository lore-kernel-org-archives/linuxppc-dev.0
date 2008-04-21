Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F1D9DDF83
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 19:51:28 +1000 (EST)
Date: Mon, 21 Apr 2008 11:51:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: x86-latest/powerpc-next merge conflict
Message-ID: <20080421095102.GB1666@elte.hu>
References: <20080421191231.41a34aef.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080421191231.41a34aef.sfr@canb.auug.org.au>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the x86-latest tree got a conflict in 
> include/asm-powerpc/bitops.h between commit 
> cd008c0f03f3d451e5fbd108b8e74079d402be64 ("generic: implement __fls on 
> all 64-bit archs") from the x86-latest tree and commit 
> 9f264be6101c42cb9e471c58322fb83a5cde1461 ("[POWERPC] Optimize fls64() 
> on 64-bit processors") from the powerpc-next tree.  The fixup was not 
> quite trivial and is worth a look to see if I got it right.

Paul, do you agree with those generic bitops changes? Just in case it's 
not obvious from previous discussions: we'll push them upstream via a 
separate pull request, not via usual x86.git changes. They originated 
from x86.git but grew into a more generic improvement for all. They sit 
in x86.git for tester convenience but are of course not pure x86 changes 
anymore.

	Ingo
