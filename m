Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E2BCFDDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 04:02:50 +1000 (EST)
Date: Mon, 14 May 2007 13:05:45 -0500
To: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 4/4] rtc-ds1307 platform update,
	powerpc mpc834x_itx and mpc8313_rdb
Message-ID: <20070514180545.GA1437@lixom.net>
References: <200705140946.41993.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705140946.41993.david-b@pacbell.net>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, rtc-linux@googlegroups.com,
	James Chapman <jchapman@katalix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 09:46:41AM -0700, David Brownell wrote:
> Update powerpc platforms to support new-style rtc-ds1307 driver:
> 
>  - Make i2c-mpc driver use numbered adapter;
>  - Update boards identified by defconfig to list a ds1339 device:
>     * mpc834x_itx
>     * mpc8313_rdb
> 
> Didn't update the pasemi reference board; public info doesn't say
> which chip it uses.

ds1338.

> NOTE:  cc'd the relevant powerpc maintainers lists; patches 1-3
> will be archived in the rtc and i2c lists.  I'd like to see these
> get tested/fixed so that the rtc-ds1307 driver can swich completely
> to use the new-style I2c driver model.

Specific URLs can sometimes be useful, so we don't have to go digging
through the archives. But thanks for the heads up, I'll make the
corresponding changes to my code and test it out.

(I'm guessing long-term, we will want to pull the chip info out of the
device tree instad of have it in a table in the board code, but that's
extra credit at the moment.)


-Olof
