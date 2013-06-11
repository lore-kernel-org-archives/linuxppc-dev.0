Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 33B6A2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 19:03:20 +1000 (EST)
Message-ID: <1370941391.8250.117.camel@pasglop>
Subject: Re: [RFC PATCH powerpc] Set cpu sibling mask before online cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Tue, 11 Jun 2013 19:03:11 +1000
In-Reply-To: <51B6E0F4.6040008@linux.vnet.ibm.com>
References: <1368699626.2618.183.camel@ThinkPad-T5421>
 <1370934016.8250.83.camel@pasglop> <51B6E0F4.6040008@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-06-11 at 14:03 +0530, Srivatsa S. Bhat wrote:
> 
> So I agree with Li Zhong's solution.
> 
> [Arch-specific CPU hotplug code consolidation efforts such as [1] would
> have weeded out such nasty bugs.. I guess we should revive that patchset
> sometime soon.]

Thanks !

Cheers,
Ben.
