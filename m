Return-Path: <jwboyer@linux.vnet.ibm.com>
Subject: Re: PageFault when I write in the Serial registers, MMU ?
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Bhupender Saharan <bhupi.saharan@gmail.com>
In-Reply-To: <720399a30707110932n5a4ddb33u552f5b01921f34b5@mail.gmail.com>
References: <4694F9BD.4090406@yahoo.fr>
	<720399a30707110932n5a4ddb33u552f5b01921f34b5@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 11 Jul 2007 12:51:00 -0500
Message-Id: <1184176260.32199.77.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-11 at 09:32 -0700, Bhupender Saharan wrote:
> Hi,
>  
> You could call io_block_mapping function from your setup.c file that
> will add the entry into MMU.

io_block_mapping doesn't exist in the arch/powerpc tree.

josh
