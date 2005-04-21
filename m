Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id B49D967A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 22:04:28 +1000 (EST)
Message-ID: <426796C7.3090501@ru.mvista.com>
Date: Thu, 21 Apr 2005 16:04:23 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@freescale.com>, linuxppc-embedded@ozlabs.org
References: <425D35E0.4040305@nm.ru> <425D5885.2040605@ru.mvista.com>
	<Pine.LNX.4.61.0504201401270.8563@linen.am.freescale.net>
In-Reply-To: <Pine.LNX.4.61.0504201401270.8563@linen.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: [PATCH 2.6.12-rc2] Freescale 8272ADS PCI bridge support to the
 stock linux-2.5 (updated)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

>On Wed, 13 Apr 2005, Vitaly Bordug wrote:
>
>Finally, had some time to really look at this patch, comments are inline. 
>Look for (galak).  A few high level comments:
>
>Can we fold pq2ads_setup_hose into pq2ads_setup_pci? 
>
No problem, I think...

> Also, is there 
>anything to be done to unify m8260_setup_pci & 
>pq2ads_setup_pci..
>
Well, in my opinion, m8260_setup_pci should be replaced with 
pq2ads_setup_pci, as far as they are intended to do the same (as I 
mentioned in my very first PCI patch marked as RFC). But I actually 
cannot test this stuff on anything other than 8272ads, so this way I'm 
trying not to break existing code. The latter, BTW, currently has 
limited functionality and I _guess_ I will not break anything if only 
pq2ads_setup_pci remain. What do you think?

Other issues will be fixed shortly.

Thanks.


-- 
Sincerely, 
Vitaly
