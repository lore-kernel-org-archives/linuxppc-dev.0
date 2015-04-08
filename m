Return-Path: <fbrozovic@gmail.com>
Received: from mail-wi0-x229.google.com (mail-wi0-x229.google.com
 [IPv6:2a00:1450:400c:c05::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2DA6E1A0515
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 22:24:49 +1000 (AEST)
Received: by wiaa2 with SMTP id a2so56272484wia.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2015 05:24:44 -0700 (PDT)
Message-ID: <55251DFB.8070907@gmail.com>
Date: Wed, 08 Apr 2015 14:24:27 +0200
From: =?UTF-8?B?RmlsaXAgQnJvem92acSH?= <fbrozovic@gmail.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc/83xx: add support for mpc8306
References: <1428057856-26421-1-git-send-email-fbrozovic@gmail.com>	
 <1428062487.7898.12.camel@x220> <551E8B65.5010400@gmail.com>
 <1428092654.22867.339.camel@freescale.com>
In-Reply-To: <1428092654.22867.339.camel@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: Paul Bolle <pebolle@tiscali.nl>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 4/3/2015 10:24 PM, Scott Wood wrote:
> What are you using PPC_MPC8306 for in your custom board code?

Sorry for the late reply, I was a bit busy over the Easter weekend.

I'm not currently using it for anything, so I guess I could remove it 
and just use PPC_MPC830x in my board code. However, I think it's best if 
this patch is ignored (for now), and I'll submit a patch series for the 
8306 and a custom board in a couple of weeks/months, when I find some 
time to clean up the board code.

- Filip
