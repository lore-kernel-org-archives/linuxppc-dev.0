Return-Path: <neko@genesi-usa.com>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16]) by ozlabs.org (Postfix) with ESMTP id B483BDE4E3
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 04:19:39 +1100 (EST)
Received: by gxk9 with SMTP id 9so4288359gxk.9
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jan 2009 09:19:38 -0800 (PST)
Sender: Matt Sealey <neko@genesi-usa.com>
Message-ID: <4968D8AF.8050402@genesi-usa.com>
Date: Sat, 10 Jan 2009 11:19:43 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/mpc52xx: Properly update irq_desc when set_type()
	is called.
References: <20090107192505.26320.23112.stgit@localhost.localdomain>	
	<4965784D.6090704@genesi-usa.com>	
	<fa686aa40901072053v7803c6afp206e0572a6c79eda@mail.gmail.com>	
	<49661041.2010302@genesi-usa.com>
	<fa686aa40901091302y12fa13b4v25bd85079ee4e7ea@mail.gmail.com>
In-Reply-To: <fa686aa40901091302y12fa13b4v25bd85079ee4e7ea@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> 
> Not entirely; it affects the details about how irqs are handled.
> check_irq_resend() for example.  I don't think any 5200 platforms
> currently care; but it could be an issue with cascaded IRQ handlers.

I'm not sure if that would be a problem or not. Would it shed some light 
on why Efika ATA DMA doesn't work? :)

-- Matt Sealey
