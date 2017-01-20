Return-Path: <tony@atomide.com>
Received: from muru.com (muru.com [72.249.23.125])
 by lists.ozlabs.org (Postfix) with ESMTP id 3v4q3Y3cl0zDrQ3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 05:28:57 +1100 (AEDT)
Date: Fri, 20 Jan 2017 10:28:50 -0800
From: Tony Lindgren <tony@atomide.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org, nsekhar@ti.com
Subject: Re: [PATCH 36/37] ARM: DRA7: clockdomain: Change the CLKTRCTRL of
 CM_PCIE_CLKSTCTRL to SW_WKUP
Message-ID: <20170120182850.GE7403@atomide.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-37-git-send-email-kishon@ti.com>
 <20170113171537.GZ2630@atomide.com> <587C628E.7070804@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <587C628E.7070804@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Kishon Vijay Abraham I <kishon@ti.com> [170115 22:06]:
> Hi Tony,
> 
> On Friday 13 January 2017 10:45 PM, Tony Lindgren wrote:
> > * Kishon Vijay Abraham I <kishon@ti.com> [170112 02:35]:
> >> The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should
> >> be set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO
> >> in RC mode. However in EP mode, the host system is not able to access the
> >> MEMSPACE and setting the CLKSTCTRL to SW_WKUP fixes it.
> > 
> > I guess ideally in the long run we would set this dynamically based on
> > the selected mode, right?
> 
> The programming sequence mentioned in the TRM w.r.t clock programming is same
> for both host mode or device mode. Though we never faced any issues in host
> mode when HW_AUTO is set, it's better to follow TRM recommended settings IMHO.

OK best to merge this with the whole series:

Acked-by: Tony Lindgren <tony@atomide.com>
