Return-Path: <kashiwagi@co-nss.co.jp>
Received: from nssinet2.co-nss.co.jp (nssinet2.co-nss.co.jp [150.96.0.5])
	by ozlabs.org (Postfix) with ESMTP id 7932FDDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 May 2008 12:13:10 +1000 (EST)
MIME-Version: 1.0
Date: Sun, 18 May 2008 11:13:10 +0900
Subject: Re: Xilinx PowerPC
From: Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>
To: dhlii@dlasys.net
Message-ID: <JV200805181113103.2504562@co-nss.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
In-Reply-To: <482EFB8F.9090402@dlasys.net>
References: <480BA36D.1080000@dlasys.net>
	<fa686aa40804201314m27caf4fau72956df9dd5d350d@mail.gmail.com>
	<480BA821.2030109@dlasys.net>
	<fa686aa40804201548o503e9b19p4081cec653a1acd2@mail.gmail.com>
	<480BD66B.90001@dlasys.net> <JM200804230904046.2598203@co-nss.co.jp>
	<482EFB8F.9090402@dlasys.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David-san,

This driver must add some corrections, for example, Checksum-offloading
is incomplete as you say it. As for me, it is very happy to obtain
your cooperation. Let me know if I can be of any work for it.

Moreover, although I wrote the xps_ll_temac driver for u-boot of a very 
simple single SDMA descriptor, I have not got used and put in the
contribution way.

Best Regards,
Yoshio Kashiwagi - Nissin Systems

>  I was able to incorporate Yoshio's driver and make use of it.
> It is a single file, fairly short, easy to understand, mostly conforming
> to linux kernel programming style. While it needs some work fo NAPI and
> OF, it is usable as it is.
> 
> I would be happy to see it form the starting point for a distribution LL
> TEMAC driver.
> 
> If Yoshio does not wish to put together a patch, for it I can, however,
> I have made some name changes and restructing to compare to my older PLB
> TEMAC.
