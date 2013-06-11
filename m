Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 360612C0095
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 17:46:33 +1000 (EST)
Message-ID: <1370936784.8250.96.camel@pasglop>
Subject: Re: [PATCH v3 00/27] EEH Support for PowerNV platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 11 Jun 2013 17:46:24 +1000
In-Reply-To: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-05 at 15:34 +0800, Gavin Shan wrote:
> Initially, the series of patches is built based on 3.10.RC1 and the patchset
> doesn't intend to enable EEH functionality for PHB3 for now. Obviously, PHB3
> EEH support on PowerNV platform is something to do in future.

One thing missing here is a first patch that moves the eeh core out of
platform/pseries or things will simply not build if CONFIG_PPC_PSERIES
isn't enabled :-)

Move the whole lot to arch/powerpc/kernel

Cheers,
Ben.
