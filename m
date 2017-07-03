Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1DSd1GJqzDr3Q
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 14:20:16 +1000 (AEST)
Message-ID: <1499055599.16202.23.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 1/2] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?=
 Le Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Date: Sun, 02 Jul 2017 23:19:59 -0500
In-Reply-To: <20170703035552.GQ13989@umbus.fritz.box>
References: <1498123757-18427-1-git-send-email-clg@kaod.org>
 <1498123757-18427-2-git-send-email-clg@kaod.org>
 <20170703035552.GQ13989@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-03 at 13:55 +1000, David Gibson wrote:
> > Calls that still need to be addressed :
> > 
> >    H_INT_SET_OS_REPORTING_LINE
> >    H_INT_GET_OS_REPORTING_LINE
> >    H_INT_ESB
> >    H_INT_SYNC
> 
> So, does this mean there's a PAPR update with the XIVE virtualization
> stuff?  Or at least an ACR?  Can we have that available please...

There is, I will try to get it published.

Cheers,
Ben.
