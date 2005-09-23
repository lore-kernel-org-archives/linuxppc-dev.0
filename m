Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id 1A8A168336
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 15:44:43 +1000 (EST)
To: mporter@kernel.crashing.org
References: <2005922203.92drttvd27WS9dXk@cisco.com>
	<2005922203.UPGbNSgrHKasoXYq@cisco.com>
	<20050923032949.GB10089@gate.ebshome.net>
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 22 Sep 2005 22:44:35 -0700
Message-ID: <52y85obanw.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2/4] [PPC32] Add 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Eugene> Roland, I recently added new field (.dcr_base) to this
    Eugene> structure (as a preparation step for new EMAC driver),
    Eugene> could you do this for 440SPe as well? It's not needed
    Eugene> right now, but as soon as new EMAC driver is in, 440SPe
    Eugene> will stop working.

    Eugene> I think you probably missed this part :)

Both fixed and pushed in a new git tree...

 - R.
