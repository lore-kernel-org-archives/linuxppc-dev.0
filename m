Return-Path: <yuehaibing@huawei.com>
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Gbhv6NtSzF3P3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 11:33:34 +1000 (AEST)
Subject: Re: [PATCH net-next 00/22] net: fix return type of ndo_start_xmit
 function
To: David Miller <davem@davemloft.net>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
 <20180920.085055.1188796939437872993.davem@davemloft.net>
CC: <dmitry.tarnyagin@lockless.no>, <wg@grandegger.com>, <mkl@pengutronix.de>,
 <michal.simek@xilinx.com>, <hsweeten@visionengravers.com>,
 <madalin.bucur@nxp.com>, <pantelis.antoniou@gmail.com>,
 <claudiu.manoil@nxp.com>, <leoyang.li@nxp.com>, <linux@armlinux.org.uk>,
 <sammy@sammy.net>, <ralf@linux-mips.org>, <nico@fluxnic.net>,
 <steve.glendinning@shawell.net>, <f.fainelli@gmail.com>,
 <grygorii.strashko@ti.com>, <w-kwok2@ti.com>, <m-karicheri2@ti.com>,
 <t.sailer@alumni.ethz.ch>, <jreuter@yaina.de>, <kys@microsoft.com>,
 <haiyangz@microsoft.com>, <wei.liu2@citrix.com>, <paul.durrant@citrix.com>,
 <arvid.brodin@alten.se>, <pshelar@ovn.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-mips@linux-mips.org>, <linux-omap@vger.kernel.org>,
 <linux-hams@vger.kernel.org>, <devel@linuxdriverproject.org>,
 <linux-usb@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
 <dev@openvswitch.org>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <83d29681-b008-9b1f-5961-e23f0174d5f4@huawei.com>
Date: Fri, 21 Sep 2018 09:33:24 +0800
MIME-Version: 1.0
In-Reply-To: <20180920.085055.1188796939437872993.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2018/9/20 23:50, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Thu, 20 Sep 2018 20:32:44 +0800
> 
>> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
>> which is a typedef for an enum type, so make sure the implementation in
>> this driver has returns 'netdev_tx_t' value, and change the function
>> return type to netdev_tx_t.
> 
> I would advise you not to send so many of these changes as a group.
> 
> If one of the patches needs feedback addressed, which is already the
> case, you will have to resubmit the entire series all over again with
> the fixes.
> 

Yes, I will send it separately after test and review again.

Thank you for your advice.

> .
> 
