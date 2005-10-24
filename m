Return-Path: <matej.kupljen@ultra.si>
Received: from deliver-1.mx.triera.net (deliver-1.mx.triera.net [213.161.0.31])
	by ozlabs.org (Postfix) with ESMTP id 51E6F685A6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Oct 2005 18:27:38 +1000 (EST)
From: Matej Kupljen <matej.kupljen@ultra.si>
To: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
In-Reply-To: <8E342283C2100540AAC5D103097054778A4189@rcexc.racoms.loc>
References: <8E342283C2100540AAC5D103097054778A4189@rcexc.racoms.loc>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 10:27:33 +0200
Message-Id: <1130142453.6895.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8xx soft-float userspace ...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

> While i was successful in compiling a glibc with -mcpu=860
> and soft-float (and without memset.S) there's still floating
> point in there. Does anybody have some pointers what else
> needs to be removed?

I had similar problems on MIPS.
Look at this threads:
http://sources.redhat.com/ml/crossgcc/2005-09/msg00054.html
http://sources.redhat.com/ml/crossgcc/2005-09/msg00063.html

BR,
Matej
