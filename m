Return-Path: <wfarnsworth@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id DAE1A688A7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 05:00:11 +1100 (EST)
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20051207173554.GA21578@gate.ebshome.net>
References: <1133968527.8299.50.camel@rhino.az.mvista.com>
	<20051207173554.GA21578@gate.ebshome.net>
Content-Type: text/plain
Message-Id: <1133978410.8298.85.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 07 Dec 2005 11:00:10 -0700
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Transmit timeouts on 440GX Ocotea on 10baseT-HD network
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2005-12-07 at 10:35, Eugene Surovegin wrote:
> Hmm, I think this should have been fixed in the latest 2.6. Check 
> that you tree has this patch:
> 
> 	[PATCH] ibm_emac: fix graceful stop timeout handling
> 
> It went in on 01 Dec. Although this fix assumed FDX operation for 
> timeouts, without collisions. Maybe I was too optimistic thinking that 
> nobody uses 10/HDX :).

That was my first thought as well, but I've tried it with the patch, and
still get the timeouts.

> 
> Try making STOP_TIMEOUT_10 bigger, say twice as big.

That doesn't seem to help any.

> 
> If this doesn't help, I'll send you patch with enables some additional 
> debugging, so I can check that stop you are experiencing is the same 
> problem I had last month.

Much appreciated.  Thanks!

Regards,

Wade Farnsworth
