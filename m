Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <200611061035.kA6AZtGZ018329@post.webmailer.de>
References: <200611061035.kA6AZtGZ018329@post.webmailer.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9580D2CE-BD68-440F-A1FD-09E882D93231@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_platform support for OHCI/Bigendian HC
Date: Mon, 6 Nov 2006 13:24:22 -0600
To: Nicolas DET <nd@bplan-gmbh.de>
Cc: "akpm@osdl.org" <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 6, 2006, at 4:35 AM, Nicolas DET wrote:

> This patch use of_platform device to probe and install OHCI big  
> endian HC.
>
> PS: I did not success to properly inline the file using thrunderbird.

You really copy the USB maintainers on this.  Also, why bother with  
the Kconfig for USB_OHCI_HCD_PPC_OF_BE/USB_OHCI_HCD_PPC_OF_LE?

- kumar

[snip]
