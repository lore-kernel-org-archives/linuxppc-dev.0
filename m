Return-Path: <randy.dunlap@oracle.com>
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.113.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 269E0DDEC9
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 01:45:04 +1000 (EST)
Date: Thu, 10 May 2007 08:48:02 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: 2.6.21-mm2 -- powerpc missing kset
Message-Id: <20070510084802.04476f66.randy.dunlap@oracle.com>
In-Reply-To: <20070510221631.5eb38bdd.sfr@canb.auug.org.au>
References: <20070509012322.199f292b.akpm@linux-foundation.org>
	<4643068C.8010302@shadowen.org>
	<20070510221631.5eb38bdd.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 May 2007 22:16:31 +1000 Stephen Rothwell wrote:

> On Thu, 10 May 2007 12:48:28 +0100 Andy Whitcroft <apw@shadowen.org> wrote:
> >
> > arch/powerpc/platforms/pseries/power.c:31: warning: `struct subsystem'
> > declared inside parameter list
> 
> There is no explicit reference to struct subsystem in the current version
> of that file.

There is in 2.6.21-mm2.  Are you saying that it's been fixed
somewhere else?  (where?)


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
