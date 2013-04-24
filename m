Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 399A72C00BE
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 02:37:14 +1000 (EST)
Message-ID: <1366821417.2869.12.camel@pasglop>
Subject: Re: [PATCH] powerpc: Add isync to copy_and_flush
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <michael.neuling@au1.ibm.com>
Date: Thu, 25 Apr 2013 02:36:57 +1000
In-Reply-To: <29244.1366799409@ale.ozlabs.ibm.com>
References: <29244.1366799409@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, miltonm@realtime.net,
 Nishanth Aravamudan <nacc@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-04-24 at 20:30 +1000, Michael Neuling wrote:
> benh: we should get this in 3.9 ASAP.

Considering that the bug has been there *forever* I don't think I have a
real standing to try to shove it down Linus throat as a "regression
fix" :-)

I'll put the fix in 3.10 and let it trickle down to stable.

Cheers,
Ben.
