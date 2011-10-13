Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 293CCB6F90
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2011 01:36:24 +1100 (EST)
Message-ID: <4E96F723.2010304@freescale.com>
Date: Thu, 13 Oct 2011 09:35:15 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] uio: Support 36-bit physical addresses on 32-bit systems
References: <1318430145-19898-1-git-send-email-galak@kernel.crashing.org>	<20111012153229.GB21852@local>	<AD39F4F8-E9C0-4090-9AEA-644F82DD328B@kernel.crashing.org>	<CAMuHMdU1rHDvZEknNqKLHyBmJ26kH7SJtxsOZmOysrSzg6bz4g@mail.gmail.com>	<CAOZdJXVLhe3aNM669sRFmDpHGCVRrP_93xdDwsY9R2VzHUZ-eQ@mail.gmail.com>
 <CAMuHMdVYsMj99jTJRj_NJ_dCg+b-39ExnDD1Mhqnv3R6tWf1iQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVYsMj99jTJRj_NJ_dCg+b-39ExnDD1Mhqnv3R6tWf1iQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "gregkh@suse.de" <gregkh@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Hans J. Koch" <hjk@hansjkoch.de>, Jiang Kai-B18973 <B18973@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:

> You deleted this part:
> 
> config PHYS_ADDR_T_64BIT
>        def_bool 64BIT || ARCH_PHYS_ADDR_T_64BIT
> 
> which enforces that PHYS_ADDR_T_64BIT is enabled if 64BIT is set.

Ok, I didn't catch that before, but it makes sense now.  Thanks.

-- 
Timur Tabi
Linux kernel developer at Freescale
