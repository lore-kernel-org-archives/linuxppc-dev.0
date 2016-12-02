Return-Path: <srinivas.kandagatla@linaro.org>
Received: from mail-wm0-x232.google.com (mail-wm0-x232.google.com
 [IPv6:2a00:1450:400c:c09::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVXYZ6jbCzDvyf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 22:51:30 +1100 (AEDT)
Received: by mail-wm0-x232.google.com with SMTP id f82so13472094wmf.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Dec 2016 03:51:30 -0800 (PST)
Subject: Re: [RFC PATCH] PCI: designware: add host_init() error handling
To: Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <1480593077-15402-1-git-send-email-srinivas.kandagatla@linaro.org>
 <f2c8ebba-e51a-5f47-2d96-c75f7e086c0e@synopsys.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han
 <jingoohan1@gmail.com>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Richard Zhu <Richard.Zhu@freescale.com>, Lucas Stach
 <l.stach@pengutronix.de>, Murali Karicheri <m-karicheri2@ti.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang
 <tie-fei.zang@freescale.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d416f9b3-20d9-0339-a4d2-9a4ba0669633@linaro.org>
Date: Fri, 2 Dec 2016 11:51:26 +0000
MIME-Version: 1.0
In-Reply-To: <f2c8ebba-e51a-5f47-2d96-c75f7e086c0e@synopsys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/12/16 10:32, Joao Pinto wrote:
>
> Hi Srinivas,
>
> Às 11:51 AM de 12/1/2016, Srinivas Kandagatla escreveu:
>>  drivers/pci/host/pci-dra7xx.c           |  4 +++-
>>  drivers/pci/host/pci-exynos.c           |  4 +++-
>>  drivers/pci/host/pci-imx6.c             |  4 +++-
>>  drivers/pci/host/pci-keystone.c         |  4 +++-
>>  drivers/pci/host/pci-layerscape.c       | 12 ++++++++----
>>  drivers/pci/host/pcie-armada8k.c        |  4 +++-
>>  drivers/pci/host/pcie-designware-plat.c |  4 +++-
>>  drivers/pci/host/pcie-designware.c      |  4 +++-
>>  drivers/pci/host/pcie-designware.h      |  2 +-
>>  drivers/pci/host/pcie-qcom.c            |  6 ++++--
>>  drivers/pci/host/pcie-spear13xx.c       |  4 +++-
>>  11 files changed, 37 insertions(+), 15 deletions(-)
>>
>
> Thanks for the patch!
>
> In my opinion your idea is good but only qcom driver is able to detect failure
> in the specific host init routine, all others have a 'return 0' even if
> something not well init. I would recomend that we take this issue a bit further
> and add the error checking to all specific pci drivers in order to make them as
> robust as qcom'.
I totally agree with you, I can give this a go in next version.

Thanks,
srini

>
> Thanks,
> Joao
>
