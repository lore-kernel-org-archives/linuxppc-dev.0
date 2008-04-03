Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E9841DE3D5
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 02:36:26 +1100 (EST)
Date: Thu, 3 Apr 2008 10:36:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Freescale QUICC Engine USB Host Controller
Message-ID: <20080403153616.GH6857@ld0162-tx32.am.freescale.net>
References: <20080311191744.GA10518@localhost.localdomain>
	<200804031545.51834.laurentp@cse-semaphore.com>
	<20080403143052.GA5955@polina.dev.rtsoft.ru>
	<47F4F8B0.4090708@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47F4F8B0.4090708@freescale.com>
Cc: linuxppc-dev@ozlabs.org, David Brownell <david-b@pacbell.net>,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 03, 2008 at 10:33:04AM -0500, Timur Tabi wrote:
> My only concern is that the functions are still called cpm_xxxx even though they
> apply to the CPM and the QE.  Sure, the QE is really just CPM3, but I'd like to
> see a nomenclature that's more inclusive.

Yeah, but cpmqe would be too clunky.  I went with cpm since it has
seniority.

-Scott
