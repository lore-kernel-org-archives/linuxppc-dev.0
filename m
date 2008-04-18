Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 156BCDE23C
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 08:38:09 +1000 (EST)
Message-Id: <3BE4A0A7-31A5-4E60-A860-BE991B601069@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <1208558149-6029-1-git-send-email-afleming@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2.6.26] powerpc: Add 8568 PHY workaround to board code
Date: Fri, 18 Apr 2008 17:37:58 -0500
References: <1208558149-6029-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 18, 2008, at 5:35 PM, Andy Fleming wrote:
> The 8568 MDS needs some configuration changes to the PHY in order to  
> work
> properly.  These are done in the firmware, normally, but Linux  
> shouldn't
> need to rely on the firmware running such things (someone could  
> disable
> the PHY support in the firmware to save space, for instance).
>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
>
> Jeff, copying you so you can see what code uses the board fixup  
> patch.  Also,
> Kumar, note that this patch is utterly useless without the patch  
> sent to netdev:
> Add support for board-level PHY fixups.

ok, I'll queue it up for a post initial pull of netdev, etc.

I'm assuming the board-level PHY fixup support has been ack'd by Jeff  
and will go into 2.6.26.

- k
