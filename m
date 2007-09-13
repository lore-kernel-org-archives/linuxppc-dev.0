Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20070913062201.GA24281@localhost.localdomain>
References: <20070913062201.GA24281@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C1ACB8E9-664A-4AAB-A815-0EABCFD5863F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Make mpc82xx use generic_calibrate_decr()
Date: Thu, 13 Sep 2007 01:43:53 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 13, 2007, at 1:22 AM, David Gibson wrote:

> The only difference between m82xx_calibrate_decr() and
> generic_calibrate_decr() is that the former computes the timebase
> frequency from the cpu node's bus-frequency property, instead of
> directly from the timebase-frequency property.
>
> But there's no reason the timebase-frequency shouldn't be correct on
> 82xx like everything else.  Certainly the 82xx bootwrapper in
> arch/powerpc/boot/cuboot-pq2.c should get it right.
>
> Therefore, this patch removes mpc82xx_calibrate_decr(), using
> generic_calibrate_decr() instead.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>
> I've compiled this, but no booted it, since I don't have any 82xx
> hardware.  I'm hoping for an ack from someone who can test boot it.

Scott's cleanup does this already for 82xx :)

- k
