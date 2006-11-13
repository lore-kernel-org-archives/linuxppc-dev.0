Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id BEA1567E4B
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 05:57:17 +1100 (EST)
Date: Mon, 13 Nov 2006 12:57:04 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH]: PowerPC: make sure the rtas stop-self token is defined.
Message-ID: <20061113185704.GA8253@localdomain>
References: <20061110182253.GV30625@austin.ibm.com>
	<17749.4445.46239.450000@cargo.ozlabs.ibm.com>
	<20061111005248.GW30625@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061111005248.GW30625@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> On Sat, Nov 11, 2006 at 10:55:09AM +1100, Paul Mackerras wrote:
> > Linas Vepstas writes:
> > 
> > > I presume this looks reasonable, please apply.
> > 
> > OK, is this a fix for a bug that needs to be fixed before 2.6.19 is
> > release?
> 
> Probably not. This was uncovered during "unusual" testing, with user
> catting values int sysfs files.  Since you need to be root to do this,
> I don't think its a security flaw.

I'm still not clear on what problem this patch is intended to address.

If the 'online' cpu attribute in sysfs can be used to attempt an
offline operation on a kernel with CONFIG_HOTPLUG_CPU=n, that's what
needs to be fixed.
