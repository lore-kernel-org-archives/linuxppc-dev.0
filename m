Return-Path: <kishon@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPBWv3m4NzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:01:45 +1100 (AEDT)
Subject: Re: [PATCH 37/37] ARM: dts: DRA7: Add pcie1 dt node for EP mode
To: Tony Lindgren <tony@atomide.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-38-git-send-email-kishon@ti.com>
 <20170120183000.GF7403@atomide.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>,
 <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58A57859.5090308@ti.com>
Date: Thu, 16 Feb 2017 15:30:57 +0530
MIME-Version: 1.0
In-Reply-To: <20170120183000.GF7403@atomide.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tony,

On Saturday 21 January 2017 12:00 AM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [170112 02:34]:
>> Add pcie1 dt node in order for the controller to operate in
>> endpoint mode. However since none of the dra7 based boards have
>> slots configured to operate in endpoint mode, keep EP mode
>> disabled.
> 
> Can this be merged separately later on without breaking anything?

yes, I'll resend this once rest of the EP support gets in.

Thanks
Kishon
