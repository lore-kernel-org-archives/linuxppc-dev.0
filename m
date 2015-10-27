Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id ACF481A027B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 10:07:02 +1100 (AEDT)
Date: Tue, 27 Oct 2015 18:06:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
 aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 01/12] PCI/IOV: Rename and export
 virtfn_add/virtfn_remove
Message-ID: <20151027230654.GA5155@localhost>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-2-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445829362-2738-2-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 26, 2015 at 11:15:51AM +0800, Wei Yang wrote:
> During EEH recovery, hotplug is applied to the devices which don't
> have drivers or their drivers don't support EEH. However, the hotplug,
> which was implemented based on PCI bus, can't be applied to VF directly.
> 
> The patch renames virtn_{add,remove}() and exports them so that they
> can be used in PCI hotplug during EEH recovery.

Trivial, but write this as an imperative sentence, e.g.,

  Rename virtn_{add,remove}() and export them so they
  can be used in PCI hotplug during EEH recovery.

"The patch" doesn't add any useful information; it's obvious that the
changelog applied to this patch.

This comment also applies to at least the next patch.

Bjorn
