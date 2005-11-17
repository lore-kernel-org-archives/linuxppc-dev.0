Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D49C568786
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 10:03:33 +1100 (EST)
Date: Thu, 17 Nov 2005 17:01:06 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: David Updegraff <dave@cray.com>
In-Reply-To: <437CFBF9.70505@cray.com>
Message-ID: <Pine.LNX.4.44.0511171659500.15752-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: PVR wrong for mpc8343 chips.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 17 Nov 2005, David Updegraff wrote:

> Hi.
> 
> The PVRs are wrongly enumerated for the 8343/8343e chips.
> 
> -dbu

Good catch.  I'll send a fixed up version of this patch upstream.

In the future take a look at Documentation/SubmittingPatches.

thanks

- kumar
