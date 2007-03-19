Return-Path: <michael.barkowski@freescale.com>
Message-ID: <45FEACA6.2060302@freescale.com>
Date: Mon, 19 Mar 2007 10:30:46 -0500
From: Michael Barkowski <michael.barkowski@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH rev2] Add MPC832x RDB board.
References: <45FE9B00.5040701@freescale.com>
	<4B63A2CD-3814-4C1F-B93A-998ED5E87A43@kernel.crashing.org>
In-Reply-To: <4B63A2CD-3814-4C1F-B93A-998ED5E87A43@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Mar 19, 2007, at 9:15 AM, Michael Barkowski wrote:
> 
> 
>>Add support for the MPC8323E Reference Development Board (RDB).   
>>The board
>>is a mini-ITX reference board with 64M DDR2, 16M flash, USB, PCI,
>>10/100 ethernet, serial, and phone ports.
>>
>>Signed-off-by: Michael Barkowski <michael.barkowski@freescale.com>
>>Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
>>---
>>Kumar, here is the respun patch with redundant bus-frequency and  
>>PCI settings removed.
>>If there are no other issues, please apply towards 2.6.22.
>>Thanks,
>>Michael
> 
> 
> Thanks.  Do you know if there are plans to add support for the phone/ 
> voice(?) functionality?
> 
> - k

Hi Kumar,
   The plans for this feature haven't been made public,
so I afraid I can't comment.

-- 
Michael
