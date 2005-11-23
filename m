Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5DBF687F2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 07:18:21 +1100 (EST)
In-Reply-To: <20051123120033.GA3551@logos.cnet>
References: <437B2051.5030408@ru.mvista.com> <20051117135810.GB9753@logos.cnet>
	<437DE07E.6080005@ru.mvista.com>
	<20051118090845.GB12765@logos.cnet>
	<17283.54950.681390.749679@cargo.ozlabs.ibm.com>
	<20051123091107.GA3482@logos.cnet>
	<ACB2F36A-0A37-4EA1-9E4A-F773AD4E0D86@kernel.crashing.org>
	<20051123120033.GA3551@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ddea89e58026c4f55f1a05af602cba60@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 23 Nov 2005 15:18:17 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc32: 8xx board-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 23, 2005, at 7:00 AM, Marcelo Tosatti wrote:

> The files in arch/ppc/8xx_io/ (which is what I think you refer to as
> candidates for drivers/), are:

I don't particularly like these macros, but I'm tired of fighting
about it.  If you follow the usage path, you will see it's only
used in the CPM drivers, and I wish people would just use
the data structure pointers to access these ports/bits with
standard C code and then place any synchronization
instructions properly.  There are some cases where you
have to be quite careful about how you read and write
some control registers, and I think this opens the possibility
to just be sloppy and make mistakes since the read/write
is hidden within the macro.


> Does anyone have hardware to test it? Dan?

Yes, I have hardware to test it.  I will do that one of these days.

Thanks.

	-- Dan
