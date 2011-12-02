Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from earthlight.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
 [81.2.110.250])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A00781007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 22:29:33 +1100 (EST)
Date: Fri, 2 Dec 2011 11:30:59 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] 8250: add workaround for MPC8[356]xx UART break IRQ
 storm
Message-ID: <20111202113059.15d73840@lxorguk.ukuu.org.uk>
In-Reply-To: <176AE2A1-6AA2-4F14-942F-8ED77AB1DBEC@kernel.crashing.org>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
 <1322783258-20443-4-git-send-email-paul.gortmaker@windriver.com>
 <4ED812E4.60905@freescale.com> <4ED81632.3030809@windriver.com>
 <176AE2A1-6AA2-4F14-942F-8ED77AB1DBEC@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > OK, I'll simply change the above to CONFIG_PPC then.
> 
> It does, the bug is in the uart IP which I don't think we ever plan on fixing, so 32 or 64-bit parts will have it for ever and ever ;)

It should be runtime selected, there should be no ifdefs here.
