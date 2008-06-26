Return-Path: <monstr@seznam.cz>
Received: from mxl.seznam.cz (mxl.seznam.cz [77.75.72.44])
	by ozlabs.org (Postfix) with ESMTP id E67CDDEB76
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 04:47:45 +1000 (EST)
Message-ID: <4863E370.9020205@seznam.cz>
Date: Thu, 26 Jun 2008 20:44:00 +0200
From: Michal Simek <monstr@seznam.cz>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 46/60] microblaze_v4: termbits.h termios.h
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>	<1214483429-32360-32-git-send-email-monstr@seznam.cz>	<1214483429-32360-33-git-send-email-monstr@seznam.cz>	<1214483429-32360-34-git-send-email-monstr@seznam.cz>	<1214483429-32360-35-git-send-email-monstr@seznam.cz>	<1214483429-32360-36-git-send-email-monstr@seznam.cz>	<1214483429-32360-37-git-send-email-monstr@seznam.cz>	<1214483429-32360-38-git-send-email-monstr@seznam.cz>	<1214483429-32360-39-git-send-email-monstr@seznam.cz>	<1214483429-32360-40-git-send-email-monstr@seznam.cz>	<1214483429-32360-41-git-send-email-monstr@seznam.cz>	<1214483429-32360-42-git-send-email-monstr@seznam.cz>	<1214483429-32360-43-git-send-email-monstr@seznam.cz>	<1214483429-32360-44-git-send-email-monstr@seznam.cz>	<1214483429-32360-45-git-send-email-monstr@seznam.cz>	<1214483429-32360-46-git-send-email-monstr@seznam.cz>	<1214483429-32360-47-git-send-email-monstr@seznam.cz>
	<20080626141837.0f8f439d@lxorguk.ukuu.org.uk>
In-Reply-To: <20080626141837.0f8f439d@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
	vapier.adi@gmail.com, arnd@arndb.de, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	John.Linn@xilinx.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, drepper@redhat.com,
	john.williams@petalogix.com
Reply-To: monstr@seznam.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

OK.I'll fix it.

M

>> +++ b/include/asm-generic/termbits.h
>> @@ -0,0 +1,200 @@
> 
>> +/* c_cflag bit meaning */
>> +
>> +#define CBAUD	0010017
>> +#define B0	0000000 /* hang up */
> 
> You need BOTHER in here as well - especially if it is going to be generic.
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
