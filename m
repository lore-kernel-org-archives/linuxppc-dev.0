Return-Path: <mark@bish.net>
Received: from vincent.bish.net (bish.net [209.241.232.100])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 69B23B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 07:00:35 +1000 (EST)
Received: from www-data by vincent.bish.net with local (Exim 4.63)
	(envelope-from <mark@bish.net>) id 1MlU6K-0000WD-Is
	for linuxppc-dev@lists.ozlabs.org; Wed, 09 Sep 2009 16:49:17 -0400
Message-ID: <20090909164912.9qa5o0v55w4o8o0o@www.bish.net>
Date: Wed, 09 Sep 2009 16:49:12 -0400
From: Mark Bishop <mark@bish.net>
To: linuxppc-dev@lists.ozlabs.org
References: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
	<20090909182227.GA8215@b07421-ec1.am.freescale.net>
In-Reply-To: <20090909182227.GA8215@b07421-ec1.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Subject: Re: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Scott Wood <scottwood@freescale.com>:

> On Fri, Sep 04, 2009 at 12:31:25PM +0200, Roland Lezuo wrote:
>> The following patch is needed to correctly assign the IRQs for the
>> gianfar driver on the MPC8313ERDB-revc boards. ERR and TX are swapped
>> as well as the interrupt lines for the two devices.
>
> And it will incorrectly assign them on older revisions of the chip.
>
> We really should have a u-boot fixup based on SVR.
>
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>

I have both versions of the boards and I use two versions of the .dts  
file.  Actually, four, two to support the old style uboot .dts that  
comes with Freescale's BSP and 2 that support the newer uboot.
