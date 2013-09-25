Return-Path: <bhelgaas@google.com>
Received: from mail-yh0-x22a.google.com (mail-yh0-x22a.google.com
 [IPv6:2607:f8b0:4002:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 402D42C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 04:02:32 +1000 (EST)
Received: by mail-yh0-f42.google.com with SMTP id z12so8835yhz.15
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 11:02:27 -0700 (PDT)
Date: Wed, 25 Sep 2013 12:02:20 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20130925180220.GB26273@google.com>
References: <20130906160621.GF22763@mtj.dyndns.org>
 <20130906233205.GF12956@google.com>
 <20130909152044.GA24962@dhcp-26-207.brq.redhat.com>
 <20130916102210.GA14102@dhcp-26-207.brq.redhat.com>
 <20130917143022.GA7707@concordia>
 <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20130918142231.GA21650@mtj.dyndns.org>
 <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
 <20130920082458.GA10507@dhcp-26-207.brq.redhat.com>
 <20130920122736.GD7630@mtj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130920122736.GD7630@mtj.dyndns.org>
Cc: Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Alexander Gordeev <agordeev@redhat.com>, Jan Beulich <JBeulich@suse.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 20, 2013 at 07:27:36AM -0500, Tejun Heo wrote:
> On Fri, Sep 20, 2013 at 10:24:59AM +0200, Alexander Gordeev wrote:
> > * Make pci_enable_msix() return 0/-errno
> 
> My choice would be this one.

I agree; it sounds like you've identified several bugs related to the
current confusing interface, so fixing that seems like the first step.

I hope we can avoid adding a plethora of interfaces to address unusual
corner cases.  But if we do the above and it turns out not to be enough,
we can always extend it later.

Bjorn
