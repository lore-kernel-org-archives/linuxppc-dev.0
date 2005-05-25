Return-Path: <dan@embeddededge.com>
In-Reply-To: <2d61cb60140e879d0c8d46e7f51a9f56@freescale.com>
References: <1116984651.6395.60.camel@gaston>
	<2d61cb60140e879d0c8d46e7f51a9f56@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <30276b84ee1e5e35bd8a9980a55296fe@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 25 May 2005 00:48:53 -0400
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: Deprecating io_block_mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 24, 2005, at 10:17 PM, Kumar Gala wrote:

> Do you propose to fixup ioremap to allocate large page resources (BATs 
> and CAMs) going forward?

That would have to be absolutely necessary, plus we need to ensure we
accommodate the processor cores with more or less BATs (or also variable
number of CAMs).  We can't afford to continue to work with the least 
common
denominator configurations and waste those resources.

Thanks.


	-- Dan
