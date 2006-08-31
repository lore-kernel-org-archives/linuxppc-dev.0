Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C5CF67B81
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Aug 2006 11:07:37 +1000 (EST)
Date: Wed, 30 Aug 2006 20:19:03 -0500
From: Matt Porter <mporter@embeddedalley.com>
To: Otto Solares <solca@guug.org>
Subject: Re: 2 Ethernet port operating in a PPC405EP system
Message-ID: <20060831011903.GB8863@gate.crashing.org>
References: <A7B1E4DD46AA7046A4398F745240F29402737D5D@ASPROEXG.astri.local>
	<20060830182303.GB25352@guug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060830182303.GB25352@guug.org>
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

On Wed, Aug 30, 2006 at 01:23:03PM -0500, Otto Solares wrote:
> Don't repeat the same mistake as the MediaMVP, it uses the same
> processor and same kernel version, it sucks badly...

FWIW, MediaMVP doesn't use the same processor. It has an
STBx25xx which is quite different from a 405EP. It is
the same 405 core at least.

-Matt
