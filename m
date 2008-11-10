Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3.cisco.com [171.71.176.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-3.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7A5B9DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 07:36:29 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH] IB/ehca: Fix suppression of port activation events
References: <200806061835.43802.fenkes@de.ibm.com>
	<48499C11.7030504@gmail.com> <200811071742.51867.fenkes@de.ibm.com>
Date: Mon, 10 Nov 2008 12:36:23 -0800
In-Reply-To: <200811071742.51867.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Fri, 7 Nov 2008 17:42:51 +0100")
Message-ID: <adaod0nqpx4.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Alexander Schmidt <alexschm@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > A previous fix introduced a regression where port activation events were
 > dropped unconditionally if port autodetection was not enabled. Fixed.

Is this a fix to "IB/ehca: Remove reference to special QP in case of
port activation failure"?  Because if so I can roll it into that patch,
since Linus hasn't pulled it yet.

 - R.
