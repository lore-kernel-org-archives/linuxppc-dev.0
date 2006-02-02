Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 210C268A75
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 12:02:06 +1100 (EST)
Date: Wed, 1 Feb 2006 18:54:09 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
In-Reply-To: <87wtgeeq8o.fsf@48ers.dk>
Message-ID: <Pine.LNX.4.44.0602011851490.22854-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org, "Jenkins, Clive" <Clive.Jenkins@xerox.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 1 Feb 2006, Peter Korsgaard wrote:

> >>>>> "Matt" == Matt Porter <mporter@kernel.crashing.org> writes:
> 
>  Matt> read*/write* and ioread*/iowrite* generate outbound little
>  Matt> endian cycles on ALL arches, period.  They are intended
>  Matt> only for PCI use and have generic names only because of
>  Matt> the assumption that "all the world is a PC".
> 
> What is the preferred way of accessing non-PCI devices then? Direct
> pointer access?

No direct pointer access is bad. On PPC You can use
in_be{8,16,32}/out_be{8,16,32}

- kumar
