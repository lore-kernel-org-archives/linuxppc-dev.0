Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgH5tQtzF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:07 +1000 (AEST)
In-Reply-To: <ac861431c98e0c259fec18a0d220994ad6b362ae.1527217866.git.sbobroff@linux.ibm.com>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2,
 01/13] powerpc/eeh: Add eeh_max_freezes to initial EEH log line
Message-Id: <40zxgG0CjHz9s2t@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-25 at 03:11:28 UTC, Sam Bobroff wrote:
> The current failure message includes the number of failures that have
> occurred in the last hour (for a device) but it does not indicate
> how many failures will be tolerated before the device is permanently
> disabled.
> 
> Include the limit (eeh_max_freezes) to make this less surprising when
> it happens.
> 
> Also remove the embedded newline from the existing message to make it
> easier to grep for.
> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/796b9f5b317a46d1b744f661c38a62

cheers
