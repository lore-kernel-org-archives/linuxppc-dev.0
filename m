Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EBAD5DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 04:01:25 +1000 (EST)
Message-ID: <4863D7E3.1030705@zytor.com>
Date: Thu, 26 Jun 2008 10:54:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Microblaze init port v4
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<200806261709.37045.arnd@arndb.de>
	<200806261951.12809.arnd@arndb.de>
In-Reply-To: <200806261951.12809.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk, vapier.adi@gmail.com,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, monstr@seznam.cz,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> 
> * You are using sys_ipc and sys_socketcall instead of the
> broken-out syscalls, which is a direct consequence of following
> the i386 numbering scheme.
> 

Please pretty please kill, kill, kill...

	-hpa
