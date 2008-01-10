Return-Path: <SRS0+8fcf70dc9041e48a7429+1600+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5DE15DE03F
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 20:15:43 +1100 (EST)
Subject: Re: add phy-handle property for fec_mpc52xx
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18309.33088.653225.116715@cargo.ozlabs.ibm.com>
References: <20080109140608.GA15673@aepfle.de> <4784E78C.40904@genesi-usa.com>
	<1199893757.2978.73.camel@pmac.infradead.org>
	<18309.33088.653225.116715@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 10 Jan 2008 09:14:35 +0000
Message-Id: <1199956475.4111.468.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: Olaf Hering <olaf@aepfle.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-01-10 at 13:21 +1100, Paul Mackerras wrote:
> David Woodhouse writes:
> 
> > It would be much better if the kernel would 'just work'. The ideal way
> > of achieving that is for the firmware to be fixed -- but that's been
> > promised for a long time now, and we just don't believe you any more. So
> > working round it in the kernel seems to be the next best option.
> 
> Does the efika use a boot wrapper?  If so then putting the fixup in
> the boot wrapper might be better.

No, it doesn't (at least for Fedora) -- we use yaboot. Perhaps we could
make yaboot run the fixups?

-- 
dwmw2
