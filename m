Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "aun.it.uu.se",
	Issuer "Uppsala University CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 135FE67A71
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Feb 2005 21:08:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16926.63745.143566.413488@alkaid.it.uu.se>
Date: Fri, 25 Feb 2005 11:08:01 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20050224160139.GF853@devserv.devel.redhat.com>
References: <16924.59237.581247.498382@alkaid.it.uu.se>
	<1109210688.15027.2.camel@gaston>
	<16925.60927.49095.758660@alkaid.it.uu.se>
	<20050224160139.GF853@devserv.devel.redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: ppc32 weirdness with gcc-4.0 in 2.6.11-rc4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jakub Jelinek writes:
 > On Thu, Feb 24, 2005 at 04:08:47PM +0100, Mikael Pettersson wrote:
 > > _However_, the 0k data message is due to a gcc-4.0 bug, and below
 > > you'll find a test program which illustrates it.
 > 
 > http://gcc.gnu.org/PR20196

Jakub's patch to gcc4 solved the mysterious "0k data" message,
but my eMac's USB is still dysfunctional. I'll try to look into
that next week.

/Mikael
