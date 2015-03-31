Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FF441A0726
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 15:24:38 +1100 (AEDT)
Message-ID: <1427775877.1072.2.camel@ellerman.id.au>
Subject: Re: [v3, 3/3] powerpc/powernv: Introduce sysfs control for
 fastsleep workaround behavior
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Date: Tue, 31 Mar 2015 15:24:37 +1100
In-Reply-To: <5519849D.9070005@linux.vnet.ibm.com>
References: <20150330102156.43CD1140161@ozlabs.org>
 <5519849D.9070005@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-30 at 22:45 +0530, Shreyas B Prabhu wrote:
> On Monday 30 March 2015 03:51 PM, Michael Ellerman wrote:
> > 
> > This sounds good, although the name is a bit vague.
 
> How about "fastsleep_workaround_permanent", with default value = 0. User
> can make workaround permanent by echoing 1 to it.

Yeah that's OK.

cheers
