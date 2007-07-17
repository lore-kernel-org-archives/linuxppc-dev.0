Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com [171.71.176.70])
	by ozlabs.org (Postfix) with ESMTP id 3D54EDDE10
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 13:50:19 +1000 (EST)
To: Joachim Fenkes <FENKES@de.ibm.com>
Subject: Re: [PATCH 10/10] IB/ehca: Support large page MRs
References: <OFD7499E67.C6B5EA9B-ONC125731A.00715FED-C125731A.007484A7@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 16 Jul 2007 20:50:13 -0700
In-Reply-To: <OFD7499E67.C6B5EA9B-ONC125731A.00715FED-C125731A.007484A7@de.ibm.com>
	(Joachim Fenkes's message of "Mon, 16 Jul 2007 23:11:47 +0200")
Message-ID: <adatzs3u1sa.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > > Why the module parameter?  Is there any reason a user would want to
 > > turn this off?  Or conversely, why is it off by default?
 > 
 > We're pretty confident this new feature works, but as with all new and 
 > possibly experimental features, there are chances it might explode your 
 > machine when activated. So, like with the scaling code, we want the user 
 > to make the conscious decision of using this code instead of activating it 
 > by default.

OK, I guess.  So can we expect to, say, change the default to turning
it on for 2.6.24 and remove the option entirely (so it's always on) in
2.6.25?

 - R.
