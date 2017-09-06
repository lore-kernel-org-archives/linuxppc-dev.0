Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xn64w2CVHzDrSB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 11:51:27 +1000 (AEST)
Message-ID: <1504662680.13106.1.camel@russell.cc>
Subject: Re: [PATCH 1/2] PCI: Remove reset argument from
 pci_iov_{add,remove}_virtfn()
From: Russell Currey <ruscur@russell.cc>
To: "Jan H." =?ISO-8859-1?Q?Sch=F6nherr?= <jschoenh@amazon.de>, Bjorn
 Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 06 Sep 2017 11:51:20 +1000
In-Reply-To: <1504653683-11543-1-git-send-email-jschoenh@amazon.de>
References: <1504653683-11543-1-git-send-email-jschoenh@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-06 at 01:21 +0200, Jan H. Schönherr wrote:
> The reset argument passed to pci_iov_add_virtfn() and
> pci_iov_remove_virtfn() is always zero since commit 46cb7b1bd86fc227a
> ("PCI: Remove unused SR-IOV VF Migration support").
> 
> Remove the argument together with the associated code.
> 
> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>

Acked-by: Russell Currey <ruscur@russell.cc>
