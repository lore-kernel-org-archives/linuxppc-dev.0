Return-Path: <bhutchings@solarflare.com>
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "WEBMAIL.SOLARFLARE.COM",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C125A2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 23:42:13 +1100 (EST)
Message-ID: <1353414988.4414.42.camel@deadeye.wl.decadent.org.uk>
Subject: Re: [PATCH] PCI: MSI: Restore read_msi_msg_desc(); add
 get_cached_msi_msg_desc()
From: Ben Hutchings <bhutchings@solarflare.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 20 Nov 2012 12:36:28 +0000
In-Reply-To: <1353396032.17856.7.camel@pasglop>
References: <20100723102202.871a3131.sfr@canb.auug.org.au>
 <1279847985.4883.391.camel@localhost> <1279850740.6381.19.camel@concordia>
 <1279893388.2089.9.camel@achroite.uk.solarflarecom.com>
 <1353396032.17856.7.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-pci <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Jesse Barnes <jbarnes@virtuousgeek.org>, Bjorn Helgaas <bhelgaas@google.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-11-20 at 18:20 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2010-07-23 at 14:56 +0100, Ben Hutchings wrote:
> > commit 2ca1af9aa3285c6a5f103ed31ad09f7399fc65d7 "PCI: MSI: Remove
> > unsafe and unnecessary hardware access" changed read_msi_msg_desc() to
> > return the last MSI message written instead of reading it from the
> > device, since it may be called while the device is in a reduced
> > power state.
> 
> Looks reasonable... Jesse ?
[...]

So reasonable that it was committed a couple of years ago!

Where did you dredge this from?

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
