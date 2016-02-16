Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4AD51A000C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 21:31:45 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 20:31:45 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2F2812BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 21:31:39 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1GAVVX262193812
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 21:31:39 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1GAV6uC029392
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 21:31:06 +1100
Date: Tue, 16 Feb 2016 16:00:30 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Petr Mladek <pmladek@suse.com>, Balbir Singh <bsingharora@gmail.com>,
 Jessica Yu <jeyu@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <jkosina@suse.cz>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 8/8] livepatch: Detect offset for the ftrace location
 during build
Message-ID: <20160216103028.GA10730@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174517.8347D692C8@newverein.lst.de>
 <1455293609.16012.9.camel@gmail.com>
 <20160212164517.GO12548@pathway.suse.cz>
 <20160216054701.GA20570@linux.vnet.ibm.com>
 <20160216082302.GA20522@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160216082302.GA20522@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Torsten Duwe <duwe@lst.de> [2016-02-16 09:23:02]:

> On Tue, Feb 16, 2016 at 11:17:02AM +0530, Kamalesh Babulal wrote:
> > * Petr Mladek <pmladek@suse.com> [2016-02-12 17:45:17]:
> > >  int test(int a)
> > >  {
> > > +	printk("%d\n", a);
> > >  	return ++a;
> > >  }
> > 
> > Thanks. This workaround, helped to load sample livepatch module.
> 
> N.b.: if you try to livepatch/trace such a leaf function without
> global dependencies, it will crash if that function got called with
> a different TOC value. Hence this whole testing.
> 

I am running out of ideas on how to generate this crash, any pointers
will be helpful.

> You may alternatively try my gcc patch ;-)

Thank you. I will give the patch a try.

Regards,
Kamalesh
