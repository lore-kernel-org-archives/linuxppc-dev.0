Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Mon, 8 Dec 2008 22:32:27 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] ndfc driver
Message-ID: <20081208223227.19a702a9@zod.rchland.ibm.com>
In-Reply-To: <20081208214512.461276d2@lappy.seanm.ca>
References: <20081203222832.3fc77d28@lappy.seanm.ca>
	<20081204090107.20269571@zod.rchland.ibm.com>
	<20081208193446.37e27e26@lappy.seanm.ca>
	<20081209021115.GA13948@oksana.dev.rtsoft.ru>
	<20081208214512.461276d2@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 8 Dec 2008 21:45:12 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> On Tue, 9 Dec 2008 05:11:15 +0300
> "Anton Vorontsov" <avorontsov@ru.mvista.com> wrote:
> 
> > So this is a controller with partitions? ;-)
> 
> Actually, I did it this way to mimic the look of the NOR. Really, we
> shouldn't care about the NAND chip.

Except there is no controller in front of the NOR.  It's all just
MMIOs.  With NDFC, there is a controller, you have to do things to it
to talk to different chips, etc.

josh
