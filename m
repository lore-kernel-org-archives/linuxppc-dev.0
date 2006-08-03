Return-Path: <miltonm@bga.com>
Date: Thu, 3 Aug 2006 13:25:26 -0500
From: Milton Miller <miltonm@bga.com>
To: dale@farnsworth.org, jean-baptiste.maneyrol@teamlog.com,
	Linuxppc-embedded@ozlabs.org,
Subject: Re: IBM OCP GPIO driver for linux 2.6
Message-Id: <311546295266b8b45674.846930886.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu Aug  3 2006 08:53:00 AM CDT, Dale Farnsworth wrote:
> The recommended way of accessing GPIO registers is to mmap them
> and manipulate them directly in user space.

> 		/* turn media led on */
> 		*reg_addr(p, OUTPUT_REG) &= ~MEDIA_LED_BIT;
> 		sleep(1);
> 		/* turn media led off */
> 		*reg_addr(p, OUTPUT_REG) |= MEDIA_LED_BIT;

Very racy if you need different bits in the same word controlled by different programs.

milton
