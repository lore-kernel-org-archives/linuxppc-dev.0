Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BB4C1A00F9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 16:34:18 +1000 (EST)
Message-ID: <1410849257.12488.3.camel@concordia>
Subject: Re: [PATCH v2 5/5] MSI: Use __read_msi_msg() instead of read_msi_msg()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Yijing Wang <wangyijing@huawei.com>
Date: Tue, 16 Sep 2014 16:34:17 +1000
In-Reply-To: <1408694880-8260-6-git-send-email-wangyijing@huawei.com>
References: <1408694880-8260-1-git-send-email-wangyijing@huawei.com>
 <1408694880-8260-6-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-08-22 at 16:08 +0800, Yijing Wang wrote:
> Read_msi_msg() only be called in rtas_setup_msi_irqs(),
> use __read_msi_msg() instead of read_msi_msg for
> simplification. And rename __read_msi_msg() to
> read_msi_msg().
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: linuxppc-dev@lists.ozlabs.org

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
