Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1299DDF54
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Feb 2008 01:23:31 +1100 (EST)
Message-Id: <3CEF10B6-C825-4FE5-BEFC-3F2512666597@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: maxime louvel <m.louvel@gmail.com>
In-Reply-To: <dda529d0802272356p5db9066s5a9aaa336e74ab81@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: 2.6.25-rc3 on mpc8548amc doesn't boot
Date: Thu, 28 Feb 2008 08:23:27 -0600
References: <dda529d0802270437o3ea1c9beld7d65f5af2011a6f@mail.gmail.com>
	<dda529d0802270825p527fd1b5i3e5a72a16bd95a75@mail.gmail.com>
	<B3C9F997-0D0B-4033-9FED-F8B6B7F5DABC@kernel.crashing.org>
	<dda529d0802272356p5db9066s5a9aaa336e74ab81@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 28, 2008, at 1:56 AM, maxime louvel wrote:

> Hi,
>
> I wanted first to check how the kernel is behaving, with a few tests.
> Then what is the best solution to do this ?
> A patch from the 2.6.25-rc3 vanilla kernel ?

2.6.25-rc3 is fine.  The best solution is against my git-tree (git:// 
git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git).

-k
