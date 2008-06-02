Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7FD6DE917
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 05:59:08 +1000 (EST)
Date: Mon, 2 Jun 2008 20:43:18 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/8] [WATCHDOG] mpc83xx_wdt: fix checkpatch issues
Message-ID: <20080602204318.4cb77070@core>
In-Reply-To: <20080602173836.GA30705@polina.dev.rtsoft.ru>
References: <20080602173726.GA24556@polina.dev.rtsoft.ru>
	<20080602173836.GA30705@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Wim Van Sebroeck <wim@iguana.be>,
	Scott Wood <scottwood@freescale.com>,
	Andrew Morton <akpm@linux-foundation.org>, Jochen
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2 Jun 2008 21:38:36 +0400
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> Quite tired of these warnings ;-), checkpatch spitting them when
> seeing the rename patch.

I've already sent the maintainer a complete overhaul of watchdog via
checkpatch.

Alan
