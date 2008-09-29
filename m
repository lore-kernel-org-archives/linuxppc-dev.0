Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BAD1CDE30D
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 02:09:12 +1000 (EST)
Message-Id: <14B8C812-4B48-463B-875B-E107D704FFEA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1222268456-22541-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v2] powerpc/math-emu: Use kernel generic math-emu code
Date: Mon, 29 Sep 2008 11:09:04 -0500
References: <1222268456-22541-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 24, 2008, at 10:00 AM, Kumar Gala wrote:

> The math emulation code is centered around a set of generic macros  
> that
> provide the core of the emulation that are shared by the various
> architectures and other projects (like glibc).  Each arch implements  
> its
> own sfp-machine.h to specific various arch specific details.
>
> For historic reasons that are now lost the powerpc math-emu code had
> its own version of the common headers.  This moves us to using the
> kernel generic version and thus getting fixes when those are updated.
>
> Also cleaned up exception/error reporting from the FP emulation  
> functions.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>
> With a better commit message, no code changes.
>
> - k

since no one seems to have any comments on this I'm going to put it  
into my powerpc-next tree.

- k
