Return-Path: <andid@gmx.net>
Received: from mncltd.com (p15112080.pureserver.info [217.160.169.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F3A567A73
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Feb 2005 20:28:44 +1100 (EST)
Message-ID: <421706C5.50200@gmx.net>
Date: Sat, 19 Feb 2005 10:28:37 +0100
From: Andre' Draszik <andid@gmx.net>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <4206ED97.2060506@gmx.net> <20050216161432.B31885@cox.net>
	<4213F112.2060606@gmx.net> <20050217103527.A5230@cox.net>
In-Reply-To: <20050217103527.A5230@cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] PPC4xx ocp ide rewrite/cleanup
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Matt Porter wrote:
> Ok, this one looks good save a few minor things that need done:

i will address these as soon as i have time again, i.e. on wednesday.

> 1) Rename from ibm_ocp_ide.[c|h] to ibm_stb_ide.[c|h] We want
>    rid of "ocp" in the file names since eventually 4xx will
>    convert to platform devices.

is diff -N appropriate for that and convenient for you? as said, i'm using 
the rsync mirror only, no bitkeeper.

> 2) Remove the #if 0'ed code...if it's not used it doesn't belong
>    in there.

ok.

> 3) Run Lindent on the driver.

ok.
Shall I send the new patch against the one I already sent or against the 
unpatched tree?

> What systems have you tested on?

On two different custom built boards both based on the redwood5 reference 
design.


a.
