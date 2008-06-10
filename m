Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D20D7DE0A5
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 00:53:08 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
Subject: Re: [PATCH REPOST] IB/ehca: In case of lost interrupts,
	trigger EOI to reenable interrupts
References: <200806101644.34693.ossrosch@linux.vnet.ibm.com>
Date: Tue, 10 Jun 2008 07:52:57 -0700
In-Reply-To: <200806101644.34693.ossrosch@linux.vnet.ibm.com> (Stefan
	Roscher's message of "Tue, 10 Jun 2008 16:44:31 +0200")
Message-ID: <adatzg15ol2.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: TKLEIN@de.ibm.com, THEMANN@de.ibm.com, fenkes@de.ibm.com,
	LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > During corner case testing, we noticed that some versions of ehca 
 > do not properly transition to interrupt done in special load situations.
 > This can be resolved by periodically triggering EOI through H_EOI, 
 > if eqes are pending.

So just to be clear: this is a workaround for a hardware/firmware bug?

 - R.
