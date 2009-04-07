Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id F02E6DDF05
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 12:26:00 +1000 (EST)
Date: Mon, 6 Apr 2009 21:27:43 -0500
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
Message-ID: <20090407022743.GA12174@lixom.net>
References: <b0b55030b7ba669cbdec74a8b89875096ea07622.1239069602.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b0b55030b7ba669cbdec74a8b89875096ea07622.1239069602.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 07, 2009 at 12:00:41PM +1000, Michael Ellerman wrote:
> Add an option, on by default, to build all code under arch/powerpc with
> -Werror, which causes gcc to treat warnings as errors.
> 
> The intention is to make it harder for people to inadvertantly introduce
> errors in the arch/powerpc code. It needs to be configurable so that
> if a warning is introduced, people can easily work around it while it's
> being fixed.

This looks useful at least for the automated builds to catch new warnings,
but do similar options exist on other architectures, x86 in particular? I
think a Cc to LKML of this could be useful.

This is really only beneficial if various people build for powerpc often
enough. If major subsystem maintainers aren't going to hit the errors
it's more of a hinderance for PPC than a global benefit, right?


-Olof
