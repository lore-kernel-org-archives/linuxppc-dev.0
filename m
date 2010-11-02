Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id 149591007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 12:50:10 +1100 (EST)
Subject: Re: [PATCH 04/39] arch/powerpc: Update WARN uses
From: Joe Perches <joe@perches.com>
To: michael@ellerman.id.au
In-Reply-To: <1288657560.16790.8.camel@concordia>
References: <cover.1288471897.git.joe@perches.com>
	<c6c46b5924e1cc9720d3ad76e6c11e982bd661e5.1288471898.git.joe@perches.com>
	<1288609334.10671.4.camel@concordia>
	<1288622509.366.237.camel@Joe-Laptop>
	<1288657560.16790.8.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Nov 2010 18:50:07 -0700
Message-ID: <1288662607.366.249.camel@Joe-Laptop>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Jiri Kosina <trivial@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-11-02 at 11:26 +1100, Michael Ellerman wrote:
> On Mon, 2010-11-01 at 07:41 -0700, Joe Perches wrote:
> > Pretty much.  Format coalescing is generally preferred for grep.
> Really? Grep doesn't work anyway because you have format specifiers, and
> although you can try and guess them .. good luck, 0x%lx, or 0x%llx, or
> %#lx or ..

grep "Breakpoint at .* will be disabled"
