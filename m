Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 0F73B2BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Sep 2004 01:17:14 +1000 (EST)
Date: Sat, 25 Sep 2004 11:10:45 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20040925134431.77E73C108D@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0409251109150.4235@dell.enoriver.com>
References: <20040925134431.77E73C108D@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] to support choice of 8xx microcode patch 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 25 Sep 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0409250834090.3738@dell.enoriver.com> you wrote:
>>
>>    yes, this is a *full* and apparently working source code patch that
>
> For which CPU types did you test it?
>
> Where do you select which CPU type gets  used,  and  adjust  for  the
> corresponfding version of the uCode patch?

are you referring to the distinction you make in the DENX 2.4 tree, 
where you distinguish between 850 and non-850 architectures?  since 
that appears to be done manually, i see no reason why the same 
couldn't be done in the patch i submitted.  it would be a trivial 
change to get the same effect.

rday
