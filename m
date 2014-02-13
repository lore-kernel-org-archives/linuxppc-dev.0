Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 34AAC2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 01:46:27 +1100 (EST)
Date: Thu, 13 Feb 2014 14:46:03 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH 2/6] PCI/arm: Use list_for_each_entry() for bus traversal
Message-ID: <20140213144603.GX26684@n2100.arm.linux.org.uk>
References: <1392297243-61848-1-git-send-email-wangyijing@huawei.com>
 <1392297243-61848-2-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392297243-61848-2-git-send-email-wangyijing@huawei.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: David Airlie <airlied@linux.ie>, linux-pcmcia@lists.infradead.org,
 Hanjun Guo <guohanjun@huawei.com>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 13, 2014 at 09:13:59PM +0800, Yijing Wang wrote:
> Replace list_for_each() + pci_bus_b() with the simpler
> list_for_each_entry().
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
