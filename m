Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.238])
	by ozlabs.org (Postfix) with ESMTP id BE72EDDF34
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 01:11:50 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so303072wri.3
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 08:11:48 -0700 (PDT)
Message-ID: <fa686aa40806050811t4ab2fbfk9eed34d0972376c4@mail.gmail.com>
Date: Thu, 5 Jun 2008 09:11:48 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	"Paul Mackerras" <paulus@samba.org>
Subject: Re: 4xx support in arch/ppc is going away Real Soon Now
In-Reply-To: <20080605095253.7df9dbe0@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080605095253.7df9dbe0@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 5, 2008 at 8:52 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> This commit (patch omitted due to size) is sitting in my local tree:
>
> commit 0d7efc1e80fc262bcc507a605482c5681e3f082a
> Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> Date:   Thu Jun 5 09:46:17 2008 -0500
>
>    ppc/4xx: Remove 4xx support from arch/ppc
>
>    Remove support for PPC 403, 405, and 440 processors from arch/ppc.  The
>    arch/powerpc equivalents should be used.  Boards that are not ported yet
>    will need to be ported to arch/powerpc to have continued support.

This looks like unneeded churn.

Paulus, Can we just kill all of arch/ppc for .27 right now?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
