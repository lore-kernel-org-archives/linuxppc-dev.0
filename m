Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by ozlabs.org (Postfix) with SMTP id 7DE032C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jan 2014 23:06:20 +1100 (EST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC] linux/pci: move pci_platform_pm_ops to linux/pci.h
Date: Mon, 06 Jan 2014 13:13:23 +0100
Message-ID: <2276888.ovWFBgDtau@vostro.rjw.lan>
In-Reply-To: <CAErSpo7+8sLZVi24fi+xxTEW2_DTJ2_zUrW+vobMGsvCEFwY_Q@mail.gmail.com>
References: <1387533832-34554-1-git-send-email-dongsheng.wang@freescale.com>
 <CAErSpo7+8sLZVi24fi+xxTEW2_DTJ2_zUrW+vobMGsvCEFwY_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Linux PM list <linux-pm@vger.kernel.org>, roy.zang@freescale.com,
 Dongsheng Wang <dongsheng.wang@freescale.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, December 20, 2013 09:42:59 AM Bjorn Helgaas wrote:
> On Fri, Dec 20, 2013 at 3:03 AM, Dongsheng Wang
> <dongsheng.wang@freescale.com> wrote:
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > make Freescale platform use pci_platform_pm_ops struct.
> 
> This changelog doesn't say anything about what the patch does.
> 
> I infer that you want to use pci_platform_pm_ops from some Freescale
> code.  This patch should be posted along with the patches that add
> that Freescale code, so we can see how you intend to use it.
> 
> The existing use is in drivers/pci/pci-acpi.c, so it's possible that
> your new use should be added in the same way, in drivers/pci, so we
> don't have to make pci_platform_pm_ops part of the public PCI
> interface in include/linux/pci.h.
> 
> That said, if Raphael thinks this makes sense, it's OK with me.

Well, I'd like to know why exactly the change is needed in the first place.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
