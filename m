Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 223F3683A1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Sep 2005 03:12:06 +1000 (EST)
Date: Fri, 23 Sep 2005 10:11:58 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Roland Dreier <rolandd@cisco.com>
Message-ID: <20050923101158.E21055@cox.net>
References: <2005922203.UPGbNSgrHKasoXYq@cisco.com>
	<2005922203.qtfGFmWm3E8jkhq1@cisco.com>
	<20050923032236.GA10089@gate.ebshome.net>
	<52irwscq49.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52irwscq49.fsf@cisco.com>;
	from rolandd@cisco.com on Thu, Sep 22, 2005 at 10:25:26PM -0700
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 3/4] [PPC32] ibm_emac: Add 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 22, 2005 at 10:25:26PM -0700, Roland Dreier wrote:
>     Eugene> Well, new driver was sent to jgarzik and netdev list three
>     Eugene> weeks ago. So far I haven't heard anything technical from
>     Eugene> Jeff. I don't know when and even if it will be merged.
> 
> Assuming everyone in the PPC4xx world thinks your driver should
> replace the old driver, it might be worth sending directly to Andrew.
> There's no reason Jeff has to become a bottleneck for this.

We're working on this. It's not exactly that simple since Jeff
established that all net drivers must enter through the netdev
tree. I expect it can get merged post 2.6.14 if all goes well.

-Matt
