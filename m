Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64E90DDE28
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 11:39:46 +1000 (EST)
Message-Id: <47FDBC52-C9C7-4948-8265-35B424BD910D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <1222026361-28133-1-git-send-email-jacmet@sunsite.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v2] powerpc: gpio driver for mpc8349/8572/8610 and
	compatible
Date: Sun, 21 Sep 2008 20:39:42 -0500
References: <1222026361-28133-1-git-send-email-jacmet@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 21, 2008, at 2:46 PM, Peter Korsgaard wrote:

> Structured similar to the existing QE GPIO support.
>
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---

Also, any plans to follow this up with .dts updates to add the GPIO  
block into the various files we have?

- k
