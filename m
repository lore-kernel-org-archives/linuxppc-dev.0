Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id 7670368365
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Sep 2005 06:25:16 +1000 (EST)
To: Matt Porter <mporter@kernel.crashing.org>
References: <2005922203.UPGbNSgrHKasoXYq@cisco.com>
	<2005922203.qtfGFmWm3E8jkhq1@cisco.com>
	<20050923032236.GA10089@gate.ebshome.net> <52irwscq49.fsf@cisco.com>
	<20050923101158.E21055@cox.net>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 23 Sep 2005 13:25:09 -0700
In-Reply-To: <20050923101158.E21055@cox.net> (Matt Porter's message of "Fri,
	23 Sep 2005 10:11:58 -0700")
Message-ID: <52d5mza5wa.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

    Matt> We're working on this. It's not exactly that simple since
    Matt> Jeff established that all net drivers must enter through the
    Matt> netdev tree. I expect it can get merged post 2.6.14 if all
    Matt> goes well.

Jeff may want all net drivers to go through his tree, but with all due
respect to him, there's no law that says it has to be so.

cf. Linus's recent post: http://lkml.org/lkml/2005/9/22/220

 - R.
