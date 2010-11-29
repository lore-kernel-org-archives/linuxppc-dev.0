Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0073B70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Nov 2010 07:25:48 +1100 (EST)
Subject: Re: [PATCH 15/15] ppc/vio: ensure dma_coherent_mask is set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <20101129194620.GA2998@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-16-git-send-email-nacc@us.ibm.com>
	<1290992577.32570.216.camel@pasglop> <20101129194620.GA2998@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Nov 2010 07:25:30 +1100
Message-ID: <1291062330.32570.308.camel@pasglop>
Mime-Version: 1.0
Cc: Brian King <brking@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-11-29 at 11:46 -0800, Nishanth Aravamudan wrote:
> > So you broke bisection... fold the patch instead or invert them
> 
> Thanks for the review. I resent this series on 10/18 and it had the
> patches folded together. 

Right, I know :-) I just mistakenly had that old one still tagged in
patchwork, my bad.

I've merged some of the new ones already.

Cheers,
Ben.
