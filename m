Return-Path: <ananth@in.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4C9972C009E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 15:37:34 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 21 Mar 2013 22:37:32 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id DC59C3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 22:37:18 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2M4bTEu121228
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 22:37:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2M4bTi9010920
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 22:37:29 -0600
Date: Fri, 22 Mar 2013 10:07:26 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] powerpc/uprobes: teach uprobes to ignore gdb breakpoints
Message-ID: <20130322043726.GA26183@in.ibm.com>
References: <20130320104033.GA19844@in.ibm.com>
 <20130320122639.GA29541@redhat.com> <20130320124301.GA30887@redhat.com>
 <20130320154245.GB8246@in.ibm.com> <20130320160728.GB20352@redhat.com>
 <20130321071707.GB5271@in.ibm.com> <20130321160002.GB20865@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130321160002.GB20865@redhat.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, stable@vger.kernel.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 21, 2013 at 05:00:02PM +0100, Oleg Nesterov wrote:
> On 03/21, Ananth N Mavinakayanahalli wrote:
> ?
> > On Wed, Mar 20, 2013 at 05:07:28PM +0100, Oleg Nesterov wrote:
> > > On 03/20, Ananth N Mavinakayanahalli wrote:
> > > >
> > > > On Wed, Mar 20, 2013 at 01:43:01PM +0100, Oleg Nesterov wrote:
> > > > > On 03/20, Oleg Nesterov wrote:
> > > > > >
> > > > > IOW, if I wasn't clear... Lets forget about gdb/etc for the moment.
> > > > > Suppose we apply the patch below. Will uprobes on powerpc work?
> > > > >
> > > > > If yes, then your patch should be fine. If not, we probably need more
> > > > > changes.
> > > >
> > > > Yes, it will work fine.
> > >
> > > Even if this new insn is conditional?
> >
> > Yes.
> 
> But this can't be true. If it is conditional, it won't always generate a
> trap, this means uprobe won't actually work.

I meant to say, uprobes if we use a conditional trap instruction as long
as the condition is met.

Ananth
