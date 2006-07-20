Return-Path: <ian@pimout5-ext.prodigy.net>
Received: from pimout5-ext.prodigy.net (pimout5-ext.prodigy.net
	[207.115.63.73]) by ozlabs.org (Postfix) with ESMTP id 0C35E67B7D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 04:38:04 +1000 (EST)
Received: from localhost (ppp-70-244-201-23.dsl.austtx.swbell.net
	[70.244.201.23])
	by pimout5-ext.prodigy.net (8.13.6 out.dk/8.13.6) with ESMTP id
	k6KIWLat264408
	for <linuxppc-embedded@ozlabs.org>; Thu, 20 Jul 2006 14:32:21 -0400
Date: Thu, 20 Jul 2006 13:32:42 -0500
From: Ian Remmler <ian@remmler.org>
To: linuxppc-embedded@ozlabs.org
Subject: Problem with ibm_emac driver
Message-ID: <20060720183242.GA22930@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm having a problem with the ibm_emac driver for the built in
gigabit ethernet on the 440gx.  I was hoping someone could shed
some light or at least point me in the right direction.

I'm using a GMS P502 board runing 2.4.27-pre3 (from GMS).  The
problem we are having is this: when we push data over the emac
interface (eth0 and eth1 both show the problem), we sporadically
get a "MAL: Rx descriptor error..." from mal_rxde in
ibm_ocp_mal.c.

Occasionally, the interface will "freeze up" for a few seconds.
An ifconfig down/up will bring it back, but from then on it will
freeze up again right away.

It looks to me like this error indicates that we're out of RX
buffers, but I don't how we would be running out.  I'm no kernel
or networking expert, but I thought the TCP stack would take
care of throttling itself to prevent that sort of thing.  I
would appreciate any help.


Thanks,
    - Ian.

-- 
"A shark on whiskey is mighty risky.
 A shark on beer is a beer engineer."
        -- Dr. Worm
