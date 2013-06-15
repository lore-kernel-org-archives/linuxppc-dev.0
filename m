Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BEF222C009C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 12:51:46 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 14 Jun 2013 20:51:43 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 28A533E40030
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 20:51:22 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5F2pejv380230
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 20:51:40 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5F2s3d7005625
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 20:54:04 -0600
Date: Fri, 14 Jun 2013 19:51:39 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Regression in RCU subsystem in latest mainline kernel
Message-ID: <20130615025139.GU5146@linux.vnet.ibm.com>
References: <1626500.7WAVXjfS9F@pcimr>
 <20130614122800.GL5146@linux.vnet.ibm.com>
 <1645938.As0LR1yeVd@pcimr>
 <1371243967.9844.338.camel@gandalf.local.home>
 <1371261741.21896.20.camel@pasglop>
 <1371262654.9844.340.camel@gandalf.local.home>
 <1371262867.21896.27.camel@pasglop>
 <1371263472.9844.341.camel@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371263472.9844.341.camel@gandalf.local.home>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Rojhalat Ibrahim <imr@rtschenk.de>, linux-kernel@vger.kernel.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 14, 2013 at 10:31:12PM -0400, Steven Rostedt wrote:
> On Sat, 2013-06-15 at 12:21 +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2013-06-14 at 22:17 -0400, Steven Rostedt wrote:
> > > On Sat, 2013-06-15 at 12:02 +1000, Benjamin Herrenschmidt wrote:
> > > > On Fri, 2013-06-14 at 17:06 -0400, Steven Rostedt wrote:
> > > > > I was pretty much able to reproduce this on my PA Semi PPC box. Funny
> > > > > thing is, when I type on the console, it makes progress. Anyway, it
> > > > > seems that powerpc has an issue with irq_work(). I'll try to get some
> > > > > time either tonight or next week to figure it out.
> > > > 
> > > > Does this help ?
> > > 
> > > It did for me. Rojhalat, did this fix your issue too?
> > 
> > Ok, adding that to what I'm about to send to Linus.
> 
> Feel free to add: Tested-by: Steven Rostedt <rostedt@goodmis.org>

Thank you both!!!

							Thanx, Paul
