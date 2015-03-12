Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 579F11A0198
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 17:52:58 +1100 (AEDT)
Message-ID: <550137C5.1020109@c-s.fr>
Date: Thu, 12 Mar 2015 07:52:53 +0100
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: fsl-spi: use of_iomap() to map parameter ram on CPM1
References: <20150226161142.D08681A2360@localhost.localdomain>
 <20150303184403.GE21293@sirena.org.uk> <54F6BBA7.8040008@c-s.fr>
 <20150306114413.GM21293@sirena.org.uk>
In-Reply-To: <20150306114413.GM21293@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 06/03/2015 12:44, Mark Brown a écrit :
> On Wed, Mar 04, 2015 at 09:00:39AM +0100, leroy christophe wrote:
>> Le 03/03/2015 19:44, Mark Brown a écrit :
>>> Why are we using of_iomap() rather than a generic I/O mapping function
>>> here?
>> because all drivers for powerpc seems to be using of_iomap(), as on powerpc
>> the HW is described by the bootloader in a OF device tree.
>> Today, of_iomap() is at least used in FSL SPI, FSL UART, SPI mpc52xx, UART
>> mpc52xx, i2c-mpc, i2c-cpm, freescale ethernet drivers, etc ....
>> Is it not correct ?
> It's legacy, all that code is really old.  Modern code is written in as
> architecture and firmware neutral a fashion as possible to make things
> more consistent and maintainable.
This patch is only a small bug fix.
That driver already contains calls to of_iomap() and other related of_ 
functions.
Is it worth rewriting the driver for just a small bug fix ?

Christophe
