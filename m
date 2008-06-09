Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9584BDE009
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 02:39:03 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] IB/ehca: In case of lost interrupts,
	trigger EOI to reenable interrupts
References: <200806091745.19147.ossrosch@linux.vnet.ibm.com>
Date: Mon, 09 Jun 2008 09:38:59 -0700
In-Reply-To: <200806091745.19147.ossrosch@linux.vnet.ibm.com> (Stefan
	Roscher's message of "Mon, 9 Jun 2008 17:45:17 +0200")
Message-ID: <adatzg28sws.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: TKLEIN@de.ibm.com, THEMANN@de.ibm.com, fenkes@de.ibm.com,
	OF-EWG <ewg@lists.openfabrics.org>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > +				if (desc->chip && desc->chip->eoi)
 > +					desc->chip->eoi(irq);

This doesn't seem like the type of thing a device driver should be
doing.  Both patches are rather short on changelog text -- what is the
issue here and how does this fix it?

 - R.
