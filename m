Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 25F63B7B92
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Oct 2009 07:36:57 +1100 (EST)
Subject: Re: powerpc problem with .data.page_aligned -> __page_aligned_data
	conversion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tim Abbott <tabbott@ksplice.com>
In-Reply-To: <alpine.DEB.1.10.0910151229340.25434@dr-wily.mit.edu>
References: <1255584772.2347.86.camel@pasglop>
	<alpine.DEB.1.10.0910151229340.25434@dr-wily.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Oct 2009 07:00:09 +1100
Message-Id: <1255636809.2347.103.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, sam@ravnborg.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-15 at 12:37 -0400, Tim Abbott wrote:
> Just to make sure I understand the nature of the problem, is the
> current 
> breakage that gcc < 4.3 will _warn_ on any compilation units on ppc64
> that 
> use __page_aligned data, or something worse?
> 
> The cropping is clearly a potential problem, but I read the rest of
> your 
> email as saying that the cropping of the alignment isn't actually a 
> problem with the current kernel because the kernel is currently only
> using 
> the macro with things whose size is divisible by PAGE_SIZE.  However,
> I am 
> not sure how to reconcile that with using the word "break" above...

Break is because we use -Werror on arch/powerpc :-)

Ben.
