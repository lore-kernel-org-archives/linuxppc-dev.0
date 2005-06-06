Return-Path: <edward.qin.hong@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.194])
	by ozlabs.org (Postfix) with ESMTP id 78DCD679E2
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Jun 2005 15:33:19 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 16so1489035nzp
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 05 Jun 2005 22:33:12 -0700 (PDT)
Message-ID: <21fb73bc050605223311af6408@mail.gmail.com>
Date: Sun, 5 Jun 2005 23:33:09 -0600
From: Edward Hong <edward.qin.hong@gmail.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050605002832.6311AC1512@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <21fb73bc0506041640736e3020@mail.gmail.com>
	<20050605002832.6311AC1512@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kernel ported from ELDK 3.0 hangs (loops in idled()) on my
	custom MPC870 Board
Reply-To: Edward Hong <edward.qin.hong@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/4/05, Wolfgang Denk <wd@denx.de> wrote:
>=20
> With "beginning of init" you mean init() in "init/main.c", right?
> So gets rest_init() called?
> Did you add a few printk's to start_kernel()?
> How far does it get?
>=20
Yes. rest_init() got called and executed kernel_thread(init,...) ...
and got into cpu_idle().
> > Any suggestions for debugging?
>=20
> Attach a BDI2000 and start GDB...
>=20
I have a BDI2000. But I am not sure how to further debug in my
situation since I know the kernel execution was looping inside
idled().

Thank you!

Edward
