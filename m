Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98B27DDECE
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 22:56:08 +1000 (EST)
Date: Sat, 27 Oct 2007 16:55:49 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: arch/powerpc/boot/wrapper broken
Message-ID: <20071027165549.3288d76e@kernel.crashing.org>
In-Reply-To: <200710271442.50158.mb@bu3sch.de>
References: <200710271442.50158.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 27 Oct 2007 14:42:49 +0200
Michael Buesch wrote:

> It calls the "mkimage" command, which does not exist
> in my $PATH.
> 
well, mkImage is a part of u-boot and there was some talk to make it part of kernel too,
since it does not take alot of place but still mandatory for a number of platforms to work.

I think, Paul will clarify the details, meanwhile you can install mkImage say building u-boot, and
some distros may have such a package.

-- 
Sincerely, Vitaly
