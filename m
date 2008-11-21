Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 76331DDDEA
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 05:28:08 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH] IB/ehca: Fix locking for shca_list_lock
References: <200806061835.43802.fenkes@de.ibm.com>
	<200811211637.15300.fenkes@de.ibm.com>
	<1227283347.3599.8.camel@johannes.berg>
	<200811211718.17489.fenkes@de.ibm.com>
Date: Fri, 21 Nov 2008 10:28:03 -0800
In-Reply-To: <200811211718.17489.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Fri, 21 Nov 2008 17:18:16 +0100")
Message-ID: <adawsexexxo.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	Alexander Schmidt <alexschm@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks good... I'll add this for 2.6.29, since as far as I can tell this
bug has been there approximately forever already.
