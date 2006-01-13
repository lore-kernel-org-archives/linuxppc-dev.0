Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 1528D689E7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jan 2006 05:31:24 +1100 (EST)
Date: Fri, 13 Jan 2006 11:31:22 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 08/10] ML300 & ML403 need embed_config.o linked in
Message-ID: <20060113113122.F402@cox.net>
References: <11367955811900-git-send-email-grant.likely@secretlab.ca>
	<87psmwq9da.fsf@48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87psmwq9da.fsf@48ers.dk>;
	from jacmet@sunsite.dk on Fri, Jan 13, 2006 at 07:18:57PM +0100
Cc: dhlii@dlasys.net, glikely@gmail.com, linuxppc-embedded@ozlabs.org,
	gnathita@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jan 13, 2006 at 07:18:57PM +0100, Peter Korsgaard wrote:
> >>>>> "grant" == grant likely <grant.likely@secretlab.ca> writes:
> 
>  grant> +boot-$(CONFIG_XILINX_ML300)	+= embed_config.o
>  grant> +boot-$(CONFIG_XILINX_ML403)	+= embed_config.o
> 
> Notice that the ML300 line already is in mainline and pending for
> 2.6.15.1.

I asked Grant to rebase against current git for the patches to
be submitted upstream so that will go away.

-Matt
