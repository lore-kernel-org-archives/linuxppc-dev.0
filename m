Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 90B942C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 13:57:53 +1000 (EST)
Message-ID: <1368590264.31689.69.camel@pasglop>
Subject: Re: [PATCH v1 00/22] powerpc/eeh: Enhance converting EEH dev
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Wed, 15 May 2013 13:57:44 +1000
In-Reply-To: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
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

On Wed, 2013-05-15 at 11:34 +0800, Gavin Shan wrote:
> e don't have existing utility (e.g. errinjct) to test the patchset. In order
> to conduct the test, you need copy over the eeh-debug.c to PowerNV platform
> directory and change the makefile accordingly. Please contact me to get the
> eeh-debug.c if you want run the test case. After that, you need write P7IOC
> registers explicitly to trigger frozen PE or fenced PHB explicitly as the
> following example shows. The patchset has been verified on Firebird-L machine
> where I have 2 Emulex ethernet card on PHB#6. I keep pinging to one of the
> ethernet cards from external and then use following commands to produce frozen
> PE or fenced PHB errors. Eventually, the errors can be recovered and the ethernet
> card is reachable after temporary connection lost.

There is an error injection framework we can use nowadays, or maybe you can
put this in tools/powerpc ?

Cheers,
Ben.
