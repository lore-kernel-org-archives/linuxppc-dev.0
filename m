Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id AF4A8DDDEF
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 09:14:26 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so577317qwb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 15:14:25 -0700 (PDT)
Message-ID: <490248C2.9020104@genesi-usa.com>
Date: Fri, 24 Oct 2008 17:14:26 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Mitch Bradley <wmb@firmworks.com>, Matt Sealey <matt@genesi-usa.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
	<4901032F.3090805@genesi-usa.com> <49011C42.2020101@firmworks.com>
	<20081024032944.GE4267@yookeroo.seuss>
	<49014C69.8020408@firmworks.com>
	<20081024044511.GI4267@yookeroo.seuss>
In-Reply-To: <20081024044511.GI4267@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



David Gibson wrote:
> Don't be patronising.
> 
> There is an existing address space defined by the gpio binding.
> Defining another one is pointless redundancy.  This is standard good
> ideas in computer science, no further argument necessary.

The existing address space, and the patches Anton etc. just submitted
which I started this discussion to address, don't fulfil certain needs.

You could do better than call it insane, by describing how you would
define a gpio bank that used 3 seperate pins which are NOT together
in a register, using a base address (reg) and base property (offset
of first pin) with the current system?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
