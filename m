Return-Path: <jakub@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0CF3467A81
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Feb 2005 03:01:48 +1100 (EST)
Date: Thu, 24 Feb 2005 11:01:39 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Message-ID: <20050224160139.GF853@devserv.devel.redhat.com>
References: <16924.59237.581247.498382@alkaid.it.uu.se>
	<1109210688.15027.2.camel@gaston>
	<16925.60927.49095.758660@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16925.60927.49095.758660@alkaid.it.uu.se>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: ppc32 weirdness with gcc-4.0 in 2.6.11-rc4
Reply-To: Jakub Jelinek <jakub@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 24, 2005 at 04:08:47PM +0100, Mikael Pettersson wrote:
> _However_, the 0k data message is due to a gcc-4.0 bug, and below
> you'll find a test program which illustrates it.

http://gcc.gnu.org/PR20196

	Jakub
