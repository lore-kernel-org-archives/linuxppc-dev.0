Return-Path: <benh@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19E6E1A0E3E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 19:26:29 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 24 Feb 2015 18:26:26 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2B8C22CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 19:26:23 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1O8QEF745350988
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 19:26:23 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1O8Pnva002616
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 19:25:49 +1100
Message-ID: <1424766317.12891.32.camel@au1.ibm.com>
Subject: Re: [PATCH V11 08/17] powrepc/pci: Refactor pci_dn
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Feb 2015 19:25:17 +1100
In-Reply-To: <20150224081330.GE6220@google.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-9-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150220231917.GC21131@google.com> <20150223001349.GA7522@shangw>
 <20150224081330.GE6220@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-24 at 02:13 -0600, Bjorn Helgaas wrote:
> 
> Ah, yes, now I see the problem.  I don't really like having to export
> pci_iov_virtfn_bus() and pci_iov_virtfn_devfn(), but it's probably not
> worth the hassle of changing it, and I think adding more pcibios
> interfaces
> would be even worse.

Aren't we going to eventually turn them all into host bridge ops ? :-)

Cheers,
Ben.
