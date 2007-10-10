Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0AE7CDDFB0
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 02:39:35 +1000 (EST)
Date: Wed, 10 Oct 2007 11:39:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: include/asm/cpm2.h:14:21: error: asm/cpm.h: No such file or
	directory
Message-ID: <20071010163901.GA4372@loki.buserror.net>
References: <4705691A.9020509@freescale.com> <13090379.post@talk.nabble.com>
	<13129025.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13129025.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 09, 2007 at 09:03:13PM -0700, Misbah khan wrote:
> 
> Please Let me know the Status 
> 
> Misbah

Are you suddenly Timur's boss? :-)

The issue was a misapplied patch in Kumar's tree.  It has been fixed, as he
pointed out in another post in this thread.

-Scott
