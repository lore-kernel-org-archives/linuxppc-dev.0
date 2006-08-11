Return-Path: <sam@ravnborg.org>
Received: from pasmtp.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id 7197A67B86
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 03:45:11 +1000 (EST)
Date: Fri, 11 Aug 2006 19:44:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 0/4]:  powerpc/cell spidernet ethernet driver fixes
Message-ID: <20060811174439.GA30191@mars.ravnborg.org>
References: <20060811170337.GH10638@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060811170337.GH10638@austin.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 11, 2006 at 12:03:37PM -0500, Linas Vepstas wrote:
> 
> The following series of patches implement some fixes and performance
> improvements for the Spedernet ethernet device driver. The high point
> of the patch series is some code to implement a low-watermark interrupt
> on the transmit queue. The bundle of patches raises transmit performance 
> from some embarassingly low value to a reasonable 730 Megabits per
> second for 1500 byte packets.
> 
> Please note that the spider is an ethernet controller that is 
> integrated into the south bridge, and is thus available only on
> Cell-based platforms.
> 
> These have been well-tested over the last few weeks. Please apply. 
Hi Linas.
Just noticed a nit-pick detail.
The general rule is to add your Signed-off-by: at the bottom of the
patch, so the top-most Signed-of-by: is also the original author whereas
the last Signed-of-by: is the one that added this patch to the kernel.
Likewise you add Cc: before your Signed-off-by: line.

See patches from for example Andrew Morton for examples.

	Sam
