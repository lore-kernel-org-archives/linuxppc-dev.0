Return-Path: <monstr@monstr.eu>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id 37AD7B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Nov 2010 17:29:54 +1100 (EST)
Received: by fxm1 with SMTP id 1so4674253fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 31 Oct 2010 23:29:51 -0700 (PDT)
Message-ID: <4CCE5E2C.6050305@monstr.eu>
Date: Mon, 01 Nov 2010 07:29:00 +0100
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: microblaze-uclinux@itee.uq.edu.au
Subject: Re: 
References: <1287422825-14999-1-git-send-email-nacc@us.ibm.com>
	<1287422825-14999-2-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1287422825-14999-2-git-send-email-nacc@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: nacc@us.ibm.com, linuxppc-dev@lists.ozlabs.org, miltonm@bga.com
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Nishanth Aravamudan wrote:
> Use set_dma_ops and remove now used-once oddly named temp pointer sd.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Cc: benh@kernel.crashing.org
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/microblaze/pci/pci-common.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)

Is there any reason why you are sending me this patch again and again?
Please STOP doing this!
This patch was added to the mainline last week.

Regards,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
