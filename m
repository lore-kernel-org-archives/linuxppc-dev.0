Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65CCADDE10
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 01:14:10 +1000 (EST)
Message-Id: <4064F5C3-0A62-4331-9116-764347AEC090@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080311172106.GA4766@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 0/8] A bit of new code and sparse cleanups along the way
Date: Mon, 14 Apr 2008 10:14:05 -0500
References: <20080311172106.GA4766@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 11, 2008, at 12:21 PM, Anton Vorontsov wrote:
> Hi all,
>
> Please consider these patches for the 2.6.26.

I've applied most of these patches to my powerpc-next branch.  The  
following two patches have NOT been applied:

[POWERPC] sysdev,qe_lib: implement FSL GTM support
[POWERPC] qe_lib: add support for QE USB

It seemed there was rework required to the sysdev,qe_lib patch.

- k
