Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1EA1167A6E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 11:11:39 +1000 (EST)
In-Reply-To: <Pine.LNX.4.61.0503291627130.16284@blarg.somerset.sps.mot.com>
References: <20050329201209.GB30850@gate.ebshome.net>
	<Pine.LNX.4.61.0503291627130.16284@blarg.somerset.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <84ab51297f043a761321ee6eddc43d4a@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 29 Mar 2005 20:10:57 -0500
To: Kumar Gala <galak@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, shall@mvista.com,
	linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: CPM2 PIC cleanup irq_to_siubit array
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 29, 2005, at 5:30 PM, Kumar Gala wrote:

> Cleaned up irq_to_siubit array so we no longer need to do 1 << 
> (31-bit),
> just 1 << bit.

Will you please put a comment in here that indicates this array now
has this computation done?  When I wrote it, these bit numbers
matched the registers and the documentation, so I didn't take
the time to explain. :-)

Thanks.


	-- Dan
