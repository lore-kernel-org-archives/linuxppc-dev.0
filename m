Return-Path: <rdreier@cisco.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 98991B7B6A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 07:26:08 +1000 (EST)
Received: from sj-iport-3.cisco.com (sj-iport-3.cisco.com [171.71.176.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-3.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 080DADDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Sep 2009 07:26:07 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH] IB/ehca: Construct MAD redirect replies from request MAD
References: <200908261337.56128.fenkes@de.ibm.com>
Date: Mon, 31 Aug 2009 14:25:59 -0700
In-Reply-To: <200908261337.56128.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Wed, 26 Aug 2009 13:37:55 +0200")
Message-ID: <adaeiqrpteg.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hal Rosenstock <hnrose@comcast.net>, LKML <linux-kernel@vger.kernel.org>,
	OF-EWG <ewg@lists.openfabrics.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

this seems reasonable to me, applied, thanks.
