Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8CDF9DDFD4
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 04:18:52 +1100 (EST)
Date: Thu, 6 Mar 2008 10:05:42 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [POWERPC] 8xx: fix swap
Message-ID: <20080306160542.GB958@ld0162-tx32.am.freescale.net>
References: <20080306135330.6d5462d2@vitb.ru.mvista.com>
	<7E836D6E-867B-4A35-9B3D-CD1D52E7F2DC@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7E836D6E-867B-4A35-9B3D-CD1D52E7F2DC@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 06, 2008 at 09:56:58AM -0600, Kumar Gala wrote:
> On Mar 6, 2008, at 4:53 AM, Vitaly Bordug wrote:
> > arch/powerpc/kernel/head_8xx.S      |   30 ++++++++++++++++++++++++++ 
> > +++-
> > include/asm-powerpc/pgtable-ppc32.h |    8 --------
> > 2 files changed, 29 insertions(+), 9 deletions(-)
> 
> do we need similar fixes to arch/ppc ?

Yes, a patch was posted a while ago.

-Scott
