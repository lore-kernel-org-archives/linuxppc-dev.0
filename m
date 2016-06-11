Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rRtR85JBVzDqT2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2016 08:06:12 +1000 (AEST)
Message-ID: <1465682743.19533.18.camel@kernel.crashing.org>
Subject: Re: case sensitivity for devicetree node names
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@secretlab.ca>,
 David Gibson <david@gibson.dropbear.id.au>,
 "devicetree-spec@vger.kernel.org" <devicetree-spec@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Paul Mackerras
 <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Sun, 12 Jun 2016 08:05:43 +1000
In-Reply-To: <575C68A1.1020701@gmail.com>
References: <575B1D84.2010703@gmail.com> <575C68A1.1020701@gmail.com>
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

On Sat, 2016-06-11 at 12:38 -0700, Frank Rowand wrote:
> I chased through the history and found a 2.6.0-test5 announcement
> which noted the patch from you which adds:
> 
>   of_find_node_by_path()
>   of_find_node_by_name()
>   of_find_node_by_type()
>   of_find_compatible_node()
> 
> (And the patch is commit 394edd852a14 in the git recreation
> of bitkeeper days, which is found at
> git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git)
> 
> That version of the functions uses a case insensitive compare for
> devicetree node names.
> 
> Do you remember why you chose to not use a case sensitive compare?

>From memory, there were inconsistency in case on various earlier
machines (notably old macs). I think that's the main reason.

Cheers,
Ben.
