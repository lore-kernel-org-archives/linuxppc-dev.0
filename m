Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id 7379D67DE5
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 03:40:02 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [openib-general] [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct
	page mapping in 64k page mode
References: <adaodrgb7uq.fsf@cisco.com>
	<OF75FFAC00.E43450CA-ONC1257222.002A402A-C1257222.002AB9BD@de.ibm.com>
	<17748.15442.906060.210242@cargo.ozlabs.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 13 Nov 2006 08:39:58 -0800
In-Reply-To: <17748.15442.906060.210242@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Fri, 10 Nov 2006 19:46:10 +1100")
Message-ID: <adahcx35mht.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, openib-general-bounces@openib.org,
	Christoph Raisch <RAISCH@de.ibm.com>,
	linux-kernel@vger.kernel.org, openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > > The patch is needed. We've seen it on the real system. We did fix it on the
 > > real system.
 > 
 > I disagree that the ioremap change is needed.

Hmm... Paul, what you say makes sense and is what I would have
thought, but Christoph says that the unpatched code really fails on a
real system.  So I'm still confused.

I think I'll merge this with a fat comment, with the hope that we can
drop it ASAP once everyone agrees on what's going on.

 - R.
