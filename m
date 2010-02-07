Return-Path: <h.thalib@gmail.com>
Received: from mail-yx0-f197.google.com (mail-yx0-f197.google.com
	[209.85.210.197]) by ozlabs.org (Postfix) with ESMTP id 76B8EB7CF5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Feb 2010 17:15:30 +1100 (EST)
Received: by yxe35 with SMTP id 35so5196545yxe.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 06 Feb 2010 22:15:27 -0800 (PST)
Message-ID: <4B6E5AAE.8020504@gmail.com>
Date: Sun, 07 Feb 2010 11:46:14 +0530
From: hmthalib <h.thalib@gmail.com>
MIME-Version: 1.0
To: Johnny Hung <johnny.hacking@gmail.com>
Subject: Re: Freescale MPC8313 TSEC SGMII problem.
References: <cb9ecdfa1001282229n21a11aa9sf15ebf279990862a@mail.gmail.com>
In-Reply-To: <cb9ecdfa1001282229n21a11aa9sf15ebf279990862a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-embedded@vger.kernel.org
Reply-To: hmthalib@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Johnny Hung,

Please find the reply inliend
Johnny Hung wrote:
> Hi All,
> 
> I have a Freescale MPC8313 customized board and want to confiugre
> TSEC1 to SGMII. Would you please help me for this question,
> 
> 1). Is it possible for MPC8313 TSEC1 connect to Ethernet Switch by
> SGMII (without phy), like below diagram.
> 
> [MPC8313 TSEC1]  <====SGMII====> [Ethernet Switch]
> 

Not possible

> 2). If yes in 1), how to configure it in MPC8313, as I know it can set
> TSEC1 to SGMII in LTIB uboot setting. How about in Linux Kernel driver
> ? Is it need extra setting or patch?
> 
> BRs, H. Johnny
> --
> To unsubscribe from this list: send the line "unsubscribe linux-embedded" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Regards,
Mohamed Thalib H
