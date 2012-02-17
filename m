Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3A3111007D5
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Feb 2012 08:10:48 +1100 (EST)
Message-ID: <1329513033.3980.1.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/85xx: fix problem that prevents PHYS_64BIT
 from configurable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tabi Timur-B04825 <B04825@freescale.com>
Date: Sat, 18 Feb 2012 08:10:33 +1100
In-Reply-To: <CAOZdJXWQzxWXhU_4WmeKXx1mfTxGQx=-JZx0AkZcF7CmRrp1gQ@mail.gmail.com>
References: <1329394210-1014-1-git-send-email-leoli@freescale.com>
 <EDB74FED-002D-4F94-B134-995BFB4C0A6B@kernel.crashing.org>
 <CAOZdJXWQzxWXhU_4WmeKXx1mfTxGQx=-JZx0AkZcF7CmRrp1gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-02-17 at 16:22 +0000, Tabi Timur-B04825 wrote:
> Was this a Freescale internal decision, or is this a generic 85xx
> decision?
> 
> For the record, I'm in favor in leaving out support for 32-bit address
> map in the upstream kernel, and having it be an option on the SDK
> only.  However, in order to do that, we cannot have "select
> PHYS_64BIT" in the Kconfigs.  It needs to be in the defconfigs
> instead.  Putting it in the defconfig will eliminate the need to have
> it in every Kconfig block, so I think that's an improvement.
> 
> Then the SDK can include a defconfig that does not have PHYS_64BIT
> defined.  And the SDK can include 32-bit U-Boots and 32-bit device
> trees for any board where Freescale determines there is a need.
> 
> I think Leo's patch simplifies things for everyone. 

Sorry, I fail to see how... it basically makes all those boards
non-functional even when enabled...

What's wrong with the current scheme ?

Ben.
