Return-Path: <neko@genesi-usa.com>
Received: from mail-qy0-f21.google.com (mail-qy0-f21.google.com
	[209.85.221.21]) by ozlabs.org (Postfix) with ESMTP id 572E4DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Nov 2008 06:45:08 +1100 (EST)
Received: by qyk14 with SMTP id 14so782057qyk.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Nov 2008 11:45:07 -0800 (PST)
Message-ID: <4925BD0A.3030307@genesi-usa.com>
Date: Thu, 20 Nov 2008 13:39:54 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Matteo Fortini <m.fortini@selcomgroup.com>
Subject: Re: MPC512x SPI very high cpu load
References: <49243010.9070106@selcomgroup.com>
In-Reply-To: <49243010.9070106@selcomgroup.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Matteo Fortini wrote:
> Hi,
> we're using the latest denx tree on an mpc512x, and we have a 
> touchscreen on the spi which is talking at 100kHz.
> 
> The polling frequency is 5ms and we transmit around 20 bytes per poll.
> 
> If we keep the touchscreen pressed, cpu utilization goes to 70% for the 
> spi task. This is quite strange, since I thought the mpc512x would be 
> using DMA to feed the PSC FIFOs.

If the SPI driver isn't using DMA then, it's not using DMA.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
