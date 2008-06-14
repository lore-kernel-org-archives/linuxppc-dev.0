Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD69CDDE21
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jun 2008 09:37:53 +1000 (EST)
Subject: Re: [Bug 10714] Badness seen on 2.6.26-rc2 with lockdep enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@kernel.org>
In-Reply-To: <20080614230424.GA21168@cs181133002.pp.htv.fi>
References: <RzbtSgMztjP.A.R0C.dIDVIB@albercik>
	<Jn7irxIunJK.A.ggF.4KDVIB@albercik>
	<20080614230424.GA21168@cs181133002.pp.htv.fi>
Content-Type: text/plain
Date: Sun, 15 Jun 2008 09:29:21 +1000
Message-Id: <1213486161.8129.89.camel@pasglop>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bugme-daemon@bugzilla.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-06-15 at 02:04 +0300, Adrian Bunk wrote:
> On Sat, Jun 14, 2008 at 10:12:02PM +0200, Rafael J. Wysocki wrote:
> > This message has been generated automatically as a part of a report
> > of recent regressions.
> > 
> > The following bug entry is on the current list of known regressions
> > from 2.6.25.  Please verify if it still should be listed.
> > 
> > 
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=10714
> > Subject		: Badness seen on 2.6.26-rc2 with lockdep enabled
> > Submitter	: Balbir Singh <balbir@linux.vnet.ibm.com>
> > Date		: 2008-05-14 12:57 (32 days old)
> > References	: http://marc.info/?l=linux-kernel&m=121076917429133&w=4
> 
> Benjamin, you said you wanted to have a look at this?

Ah yes, slipped out of my mind. It's probably a missing annotation in
the RTAS code, I'll have a look tomorrow.

Thanks,
Ben.
