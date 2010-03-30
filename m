Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2DEF8B7CEF
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Mar 2010 09:29:00 +1100 (EST)
Subject: Re: [PATCH] fix the problem where pcix node is probed again as pci
	node.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Feng Kan <fkan@amcc.com>
In-Reply-To: <0A09B731-3A34-4144-BCA3-25FDFB9DB466@amcc.com>
References: <1269970878-5080-1-git-send-email-fkan@amcc.com>
	<1269982097.7101.52.camel@pasglop> <1269983680.7101.53.camel@pasglop>
	<0A09B731-3A34-4144-BCA3-25FDFB9DB466@amcc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 31 Mar 2010 09:28:53 +1100
Message-ID: <1269988133.7101.62.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Tirumala R Marri <tmarri@appliedmicro.com>,
	Feng Kan <fkan@appliedmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-03-30 at 15:02 -0700, Feng Kan wrote:
> Ok thanks. This short string match may be useful in some cases, but I
> agree it plays havoc with the current code.

Yeah well, it's not actually -that- useful and is definitely broken :-)

If you want multiples matches, then it's the compatible property itself
that should contain multiple entries since it's a list. The string match
should be exact.

Cheers,
Ben.
