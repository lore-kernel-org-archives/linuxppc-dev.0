Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 404D32BD46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Oct 2004 00:56:30 +1000 (EST)
Date: Tue, 19 Oct 2004 07:31:22 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20041019073122.B29957@home.com>
References: <1098072098.751.32.camel@nighteyes.localdomain>
	<41738D27.4060007@eircom.net>
	<BE328096-211A-11D9-8079-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BE328096-211A-11D9-8079-003065F9B7DC@embeddededge.com>;
	from dan@embeddededge.com on Mon, Oct 18, 2004 at 11:31:12AM -0400
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Does kmalloc on MPC82xx work correctly with GFP_DMA?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 18, 2004 at 11:31:12AM -0400, Dan Malek wrote:
> No, the kmalloc() space is not covered by BATs (but, that isn't
> relevant for this discussion).

Dan, I think you forgot that green book PPCs get kernel lowmem
("kmalloc() space") covered by BATs if possible...unless you
pass in "nobats".

-Matt
