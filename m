Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.197])
	by ozlabs.org (Postfix) with ESMTP id 4B45867A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 19:54:24 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so584448wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 02:54:22 -0700 (PDT)
Message-ID: <9b7ca65705042102544b9db187@mail.gmail.com>
Date: Thu, 21 Apr 2005 18:54:22 +0900
From: Daniel Ann <ktdann@gmail.com>
To: Marco Schramel <Schramel.Linux@go.bartec.de>
In-Reply-To: <200504211117.25584.Schramel.Linux@go.bartec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200504211117.25584.Schramel.Linux@go.bartec.de>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: mtd mount problem
Reply-To: Daniel Ann <ktdann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/21/05, Marco Schramel <Schramel.Linux@go.bartec.de> wrote:
> It all seems to be fine, but...
>=20
> dev # mount -t jffs2 /dev/mtdblock1 /mnt/Flash1
> mount: Mounting /dev/mtdblock1 on /mnt/Flash1 failed: No such device

Shouldnt you be doing eraseall first ? It seems to me, you were
writing output of date to the flash earlier.

If you get No such device, it maybe that your configuration of bus
width, and base address could be wrong. (I take it that you did
configure the physmap)

--=20
Daniel
