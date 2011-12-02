Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD35DB6F65
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 14:04:41 +1100 (EST)
Message-ID: <1322795058.3729.48.camel@pasglop>
Subject: Re: [PATCH 10/10] powerpc/mpic: Add in-core support for cascaded MPICs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
Date: Fri, 02 Dec 2011 14:04:18 +1100
In-Reply-To: <CDCF68E8-7EF4-4ED7-A1FA-2A2CE74287CB@boeing.com>
References: <1322593117-29938-1-git-send-email-Kyle.D.Moffett@boeing.com>
 <1322593117-29938-11-git-send-email-Kyle.D.Moffett@boeing.com>
 <1322722788.5215.3.camel@concordia>
 <CDCF68E8-7EF4-4ED7-A1FA-2A2CE74287CB@boeing.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 "michaele@au1.ibm.com" <michaele@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-12-01 at 19:48 -0600, Moffett, Kyle D wrote:
> Ben,
> 
> I fixed the 3 issues that Paul and Michael reported and I can provide them
> to you two different ways, however you would prefer.  I can also send the
> patches via email if that's more convenient.
> 
> Option 1: Squashed into the the original patches for bisectability:
>   git://opensource.exmeritus.com/hww-1u-1a/linux.git mpc85xx/mpic-and-stuff

This option, please just re-send to the list.

Cheers,
Ben.
