Date: Thu, 21 Nov 2002 08:47:33 -0700
From: Matt Porter <porter@cox.net>
To: Eugene Surovegin <ebs@innocent.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] correct initialization sequence in ppc405_enet_open
Message-ID: <20021121084733.B8252@home.com>
References: <5.1.0.14.2.20021120212220.00aebfa0@pop.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20021120212220.00aebfa0@pop.prodigy.net>; from ebs@innocent.com on Wed, Nov 20, 2002 at 09:47:34PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Nov 20, 2002 at 09:47:34PM -0800, Eugene Surovegin wrote:
>
> Hi!
>
> This patch fixes problem in drivers/net/ibm_ocp/ibm_ocp_enet.c.

<snip>

> This patch is against current devel_2_4, but I think should apply without
> any problems to devel_2_5 also.

Looks good, applied to both trees.

Thanks,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
