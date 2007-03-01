Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 509F2DDEFE
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 01:25:34 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so339876ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 01 Mar 2007 06:25:32 -0800 (PST)
Message-ID: <528646bc0703010625o92ff794ra5ba561b0861f2e3@mail.gmail.com>
Date: Thu, 1 Mar 2007 07:25:31 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH 0/7] MPC5200 and Lite5200b low power modes
In-Reply-To: <20070301075323.GP4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070301075323.GP4397@moe.telargo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 3/1/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> Hi!
>
> Patches are based on latest mainline git tree + fec patches:
> Fec_MPC5200_eth_driver.patch
> Copy_bestcomm_support_files_into_arch_powerpc.patch
> Make_FEC_work_on_the_lite5200.patch
>
---8<---snip--->8---
>
> I would appreaciate any comments, suggestions etc.

Cool, good work.  I'll try to do a proper review today.

Note on the Bestcomm stuff; the patches that you've referenced above
will not be going into mainline.  They will be replaced by a new set
of bestcomm/FEC patches, hopfully in the .22 timeframe, so your
patches there will need some rework.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
