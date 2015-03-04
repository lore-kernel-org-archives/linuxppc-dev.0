Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71BF81A01DA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 16:54:44 +1100 (AEDT)
Message-ID: <1425448483.9084.14.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mpc85xx: Add MDIO bus muxing support to the
 board device tree(s)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Wed, 04 Mar 2015 16:54:43 +1100
In-Reply-To: <54F484DE.30204@Freescale.com>
References: <1425310332-21744-1-git-send-email-Emilian.Medve@Freescale.com>
 <54F484DE.30204@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: devicetree@vger.kernel.org, Shruti Kanetkar <Kanetkar.Shruti@gmail.com>,
 Igal Liberman <Igal.Liberman@Freescale.com>, scottwood@Freescale.com,
 afleming@gmail.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-02 at 09:42 -0600, Emil Medve wrote:
> On 03/02/2015 09:32 AM, Emil Medve wrote:
> > From: Igal Liberman <Igal.Liberman@freescale.com>
> > 
> > Describe the PHY topology for all configurations supported by each board
> > 
> > Based on prior work by Andy Fleming <afleming@gmail.com>
> > 
> > Change-Id: I4fbcc5df9ee7c4f784afae9dab5d1e78cdc24f0f
> 
> Bah, I'll remove this...

Something like:

$ cat .git/hooks/commit-msg
#!/bin/sh

grep "Change-Id:" $1 > /dev/null

if [ $? -eq 0 ]; then
	echo "***: Error commit message includes Change-Id" >&2
	exit 1
fi
	

Ought to do it.

cheers
