Return-Path: <mgreer@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id DA9D96857D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 04:17:47 +1000 (EST)
Date: Thu, 27 Oct 2005 11:17:51 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Ashish Bijlani <ashish.bijlani@gmail.com>
Message-ID: <20051027181751.GD9628@mag.az.mvista.com>
References: <ec55b17e0510270617k368b4555gf3f37e07cee3b4e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ec55b17e0510270617k368b4555gf3f37e07cee3b4e6@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Board based on MPC7447 and MV64462
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 27, 2005 at 06:47:29PM +0530, Ashish Bijlani wrote:
> Hi,
> 
> I've added platform support for a board based on MPC7447A and MV64462
> Marvell Discovery III system controller. I modified code for Katana to make
> it work for this board. The ethernet and serial are working fine but I don't
> see anything in "lspci" output.

Do you have any pci devices?  If not, then that's to be expected.
If you do, then you have something messed up in your code and they
aren't being found.

> Also I don't see timer in "cat /proc/interrupts".

Neither do I...  :)

Mark
