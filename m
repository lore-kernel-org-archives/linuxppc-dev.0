Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93DA1DDED5
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 09:11:03 +1100 (EST)
Date: Fri, 23 Nov 2007 01:06:01 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: John Charles Tyner <jtyner@cs.ucr.edu>
Subject: Re: oops trying to execute sh
Message-ID: <20071123010601.415b5761@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0711211149210.3338@eon.cs.ucr.edu>
References: <Pine.LNX.4.64.0711211149210.3338@eon.cs.ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 Nov 2007 11:54:01 -0800 (PST)
John Charles Tyner wrote:

> I'm trying to boot linux 2.6.22.9 on an mpc860c rev d4.
> 
ppc or powerpc?


> When init trys to spawn sh, during the exec, the kernel oopses as
> seen below:
This looks like coherency problem, or kernel picks wrong entry off cputable.
I think I recall something similar when I lost a hunk applying patch for new e300 core.
... or not. The game across that ff8.. value is very confusing.

> 

-- 
Sincerely, Vitaly
