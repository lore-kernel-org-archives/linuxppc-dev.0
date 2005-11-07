Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 865826869C
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Nov 2005 08:22:15 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
In-Reply-To: <20051107201011.3b1e4db4.pochini@shiny.it>
References: <20051107201011.3b1e4db4.pochini@shiny.it>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 08:21:54 +1100
Message-Id: <1131398514.4652.59.camel@gaston>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Linux 2.6.14 and ALSA
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-11-07 at 20:10 +0000, Giuliano Pochini wrote:
> 
> I know there is a big ppc32-ppc64 merge in progress. Anyway, with Linux
> 2.6.14 alsa-driver doesn't compile anymore. The configure script cannot
> compile many of its mini test programs because it cannot find the following
> headers. This is not a bug report. This is just a (incomplete?) list of
> files that have still to be moved in order to make alsa compile. I hope it
> helps.

Just include include/asm-powerpc before include/asm-ppc, we do that with
an "asm" symlink link in the arch code

Ben.
