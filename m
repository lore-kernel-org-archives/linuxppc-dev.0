Return-Path: <wfarnsworth@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 7B9A368888
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 03:54:36 +1100 (EST)
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <1133968527.8299.50.camel@rhino.az.mvista.com>
References: <1133968527.8299.50.camel@rhino.az.mvista.com>
Content-Type: text/plain
Message-Id: <1133974474.8298.74.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 07 Dec 2005 09:54:34 -0700
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

On Wed, 2005-12-07 at 08:15, Wade Farnsworth wrote:
> Hi Eugene,
> 
> I'm seeing some "NETDEV WATCHDOG: eth0: transmit timed out" messages on
> the Ocotea when it's connected to a 10baseT hub, and it's put under
> heavy load.  I'm using the most current 2.6 git tree.
> 
> This can be reproduced by ssh'ing into the Ocotea and running the
> command "ping <host-machine> -A -s 1200", then also doing the same ping
> command from the host to the Ocotea.  The pings will be successful for a
> short time, then all transmits on the Ocotea will stop for a few seconds
> (usually preceded by a few duplicate packets).  Transmits begin again
> once the timeout occurs. /proc/net/dev doesn't report any errors, just a
> few dropped packets.
> 
> Do you know what might be causing the EMAC to stop transmitting in this
> situation?

One more data point to consider:  I ran this test on an Ebony board, but
don't encounter any timeouts.  Do you know of any 440GX-specific issues
that might cause this?

Thanks again,

Wade Farnsworth
