Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 39D7FDDE21
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 16:12:06 +1000 (EST)
Date: Tue, 5 Aug 2008 02:12:05 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Message-ID: <20080805021205.438365c0@lappy.seanm.ca>
In-Reply-To: <18582.35404.120586.238398@drongo.ozlabs.ibm.com>
References: <18582.35404.120586.238398@drongo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 4 Aug 2008 14:49:16 +1000
"Paul Mackerras" <paulus@samba.org> wrote:

> Linus,
> 
> Please pull from the 'merge' branch of
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
> 
> The main thing there is that we have moved the powerpc include files
> from include/asm-powerpc to arch/powerpc/include/asm.  There is also a
> commit from Kumar Gala that removes code that was only referenced when
> compiling with ARCH=ppc, and is now dead since arch/ppc is gone, plus
> a couple of warning fixes from Tony Breeds.

What is the "correct" way to include these files? I have a driver
that needs to access get_tbl() which is defined in time.h.

Do I put:

#include <arch/powerpc/include/asm/time.h>

in the source file?

Cheers,
   Sean
