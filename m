Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A91EDE5AC
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 01:19:00 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m55FIv5q029787
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 11:18:57 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m55FIvuJ116564
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 09:18:57 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m55FIuGp008083
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 09:18:56 -0600
Date: Thu, 5 Jun 2008 10:18:38 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: 4xx support in arch/ppc is going away Real Soon Now
Message-ID: <20080605101838.5b1d9233@zod.rchland.ibm.com>
In-Reply-To: <fa686aa40806050811t4ab2fbfk9eed34d0972376c4@mail.gmail.com>
References: <20080605095253.7df9dbe0@zod.rchland.ibm.com>
	<fa686aa40806050811t4ab2fbfk9eed34d0972376c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 5 Jun 2008 09:11:48 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On Thu, Jun 5, 2008 at 8:52 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > This commit (patch omitted due to size) is sitting in my local tree:
> >
> > commit 0d7efc1e80fc262bcc507a605482c5681e3f082a
> > Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > Date:   Thu Jun 5 09:46:17 2008 -0500
> >
> >    ppc/4xx: Remove 4xx support from arch/ppc
> >
> >    Remove support for PPC 403, 405, and 440 processors from arch/ppc.  The
> >    arch/powerpc equivalents should be used.  Boards that are not ported yet
> >    will need to be ported to arch/powerpc to have continued support.
> 
> This looks like unneeded churn.

Excellent.  My prompting has succeeded.  Though now I won't get to be
on top of the "top contributors" list in the lwn.net pages like Kumar
was.  Oh well.

> Paulus, Can we just kill all of arch/ppc for .27 right now?

Please.  Pretty please?

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
