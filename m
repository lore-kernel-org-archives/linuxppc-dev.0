Return-Path: <jlinton@tributary.com>
Received: from relay05.mycloudmailbox.com (relay05.mycloudmailbox.com
 [199.244.76.201])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7844B1A0FF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2015 04:14:54 +1000 (AEST)
Message-ID: <5592DC98.8070805@tributary.com>
Date: Tue, 30 Jun 2015 13:14:48 -0500
From: Jeremy Linton <jlinton@tributary.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@linaro.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Jeremy Linton <lintonrjeremy@gmail.com>
CC: <robherring2@gmail.com>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <paulus@samba.org>
Subject: Re: [PATCH] Fix pSeries boot failure,
 by returning interrupt controller
 node when an interrupt-map property doesn't exist
References: <CAEFTgixGKnMuMGp2DfoksqF0m_P6-EGJ0sUjg2=ReX2X0tq2nA@mail.gmail.com>	<1435634613.26815.78.camel@kernel.crashing.org>
 <20150630160156.7010DC405A7@trevor.secretlab.ca>
In-Reply-To: <20150630160156.7010DC405A7@trevor.secretlab.ca>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/30/2015 11:01 AM, Grant Likely wrote:
> Merged, thanks.
	Thanks!

> Jeremy, please check your mailer configuration. The patch was mangled
> and would not apply. I had to fix it up manually.

	Sorry about that, I will see about creating a better setup (aka not gmail/web
client) for patches I send from home.

> Also, does this patch need to be backported into stable? What commit
> introduced this bug, and which kernel does it first appear in?

	I didn't bisect the problem so i'm not 100% sure, but I think the commit that
caused this was 2361613206e66ce59cc0e08efa8d98ec15b84ed1 AKA 3.13. For me I
don't need stable, I just pulled the machine forward on a whim in order to build
some other things. I will try to do that more frequently due to the fact that
the bug existed for a little over a year..


	
