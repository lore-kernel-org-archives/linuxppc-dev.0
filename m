Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0A0312C009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 02:08:22 +1000 (EST)
Date: Mon, 30 Jul 2012 16:45:36 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [2/3][PATCH][v2] TDM Framework
Message-ID: <20120730154536.GA3218@sirena.org.uk>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727152542.GB1613@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120727152542.GB1613@electric-eye.fr.zoreil.com>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 sandeep@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 27, 2012 at 05:25:42PM +0200, Francois Romieu wrote:

> 2. It would probably make sense to Cc: netdev and serial. There may be
>    some kernel client network integration from the start.

Plus audio, quite a few of the buses mentioned as examples of use cases
for the hardware are audio ones.
