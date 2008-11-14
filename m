Return-Path: <michael.barkowski@freescale.com>
Message-ID: <491D9643.4010204@freescale.com>
Date: Fri, 14 Nov 2008 10:16:19 -0500
From: Michael Barkowski <michael.barkowski@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] mpc832x_rdb: fix swapped ethernet ids
References: <491C4544.7020707@freescale.com>
	<20081113234507.GB32024@yookeroo.seuss>
In-Reply-To: <20081113234507.GB32024@yookeroo.seuss>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Thu, Nov 13, 2008 at 10:18:28AM -0500, Michael Barkowski wrote:
>> ethernet0 (called FSL UEC0 in U-Boot) should be enet1 (UCC3/eth1), and
>> ethernet1 should be enet0 (UCC2/eth0), to be consistent with U-Boot so
>> that the interfaces do not swap addresses when control passes from
>> U-Boot to the kernel.
> 
> Um.. why is just swapping the aliases, rather than the enet labels the
> right approach here?

Kim suggested it was better to localize the port ordering as a property of the board rather than that of the QE, and I agreed.

-- 
Michael
