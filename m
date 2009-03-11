Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09033DE03F
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 08:02:32 +1100 (EST)
Message-ID: <49B826E3.6020007@freescale.com>
Date: Wed, 11 Mar 2009 16:02:27 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
References: <1236723118-3577-1-git-send-email-timur@freescale.com>	
	<49B6EAA4.9000803@freescale.com>	
	<20090310223753.GB26415@zod.rchland.ibm.com>	
	<1236729551.7086.26.camel@pasglop>	
	<ed82fe3e0903101722i610638e8le1f2e925095c8ba6@mail.gmail.com>	
	<adaiqmgbq6w.fsf@cisco.com>	
	<ed82fe3e0903110931y62e23a02yf2a9719e5a69bd2@mail.gmail.com>	
	<49B7EC27.3030305@freescale.com>	
	<ed82fe3e0903111214j2072319pe985e6bbecdd1665@mail.gmail.com>	
	<49B80F7F.30705@freescale.com>
	<ed82fe3e0903111345m2962f5b5wdfc9e2efae1c33ae@mail.gmail.com>
	<49B82657.9050709@freescale.com>
In-Reply-To: <49B82657.9050709@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Roland Dreier <rdreier@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

 > Or you can say that atomic context is outside the scope of this macro.

No, I don't want to say that.  We have wait_event_timeout() for larger-scale 
operations.  I'm just looking for something that can replace "while (!condition);"

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
