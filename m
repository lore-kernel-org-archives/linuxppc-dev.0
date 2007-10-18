Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C19E1DDDD8
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 11:48:41 +1000 (EST)
Date: Wed, 17 Oct 2007 19:48:36 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: 2.6.23-mm1 - build failure with advansys
Message-ID: <20071018014836.GC14883@parisc-linux.org>
References: <20071011213126.cf92efb7.akpm@linux-foundation.org>
	<47104D26.7050206@linux.vnet.ibm.com>
	<20071012235242.9d7daf05.akpm@linux-foundation.org>
	<18198.41946.697397.255427@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18198.41946.697397.255427@cargo.ozlabs.ibm.com>
Cc: Matthew Wilcox <willy@debian.org>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 18, 2007 at 10:07:54AM +1000, Paul Mackerras wrote:
> The correct fix is to make advansys depend on CONFIG_VIRT_TO_BUS, or
> alternatively fix advansys.c properly by making it use the interfaces
> described in Documentation/DMA-mapping.txt (or the equivalent scsi
> helpers).

If you look at the git logs, you'll notice there's some progress towards
this.  It's already the case for the narrow boards.  I have a patch to
rip it all out for the wide boards, but there's clearly a bug because it
crashes my parisc machine.  Works fine on x86 though.  I can't work on
it this week because I'm travelling and the parisc machine with remote
power died on me last week.

I think I already suggested a temporary CONFIG_VIRT_TO_BUS dependency to
akpm last week.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
