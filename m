Return-Path: <jacmet@gmail.com>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.188])
	by ozlabs.org (Postfix) with ESMTP id B9E01DF537
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 00:17:25 +1000 (EST)
Received: by gv-out-0910.google.com with SMTP id y18so10943gvf.14
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 07:17:23 -0700 (PDT)
To: monstr@seznam.cz
Subject: Re: [PATCH 60/60] microblaze_v4: Enable drivers for Microblaze
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-42-git-send-email-monstr@seznam.cz>
	<1214483429-32360-43-git-send-email-monstr@seznam.cz>
	<1214483429-32360-44-git-send-email-monstr@seznam.cz>
	<1214483429-32360-45-git-send-email-monstr@seznam.cz>
	<1214483429-32360-46-git-send-email-monstr@seznam.cz>
	<1214483429-32360-47-git-send-email-monstr@seznam.cz>
	<1214483429-32360-48-git-send-email-monstr@seznam.cz>
	<1214483429-32360-49-git-send-email-monstr@seznam.cz>
	<1214483429-32360-50-git-send-email-monstr@seznam.cz>
	<1214483429-32360-51-git-send-email-monstr@seznam.cz>
	<1214483429-32360-52-git-send-email-monstr@seznam.cz>
	<1214483429-32360-53-git-send-email-monstr@seznam.cz>
	<1214483429-32360-54-git-send-email-monstr@seznam.cz>
	<1214483429-32360-55-git-send-email-monstr@seznam.cz>
	<1214483429-32360-56-git-send-email-monstr@seznam.cz>
	<1214483429-32360-57-git-send-email-monstr@seznam.cz>
	<1214483429-32360-58-git-send-email-monstr@seznam.cz>
	<1214483429-32360-59-git-send-email-monstr@seznam.cz>
	<1214483429-32360-60-git-send-email-monstr@seznam.cz>
	<1214483429-32360-61-git-send-email-monstr@seznam.cz>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Thu, 26 Jun 2008 16:16:39 +0200
In-Reply-To: <1214483429-32360-61-git-send-email-monstr@seznam.cz>
	(monstr@seznam.cz's message of "Thu\,
	26 Jun 2008 14\:30\:29 +0200")
Message-ID: <87d4m4i8mw.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, arnd@arndb.de,
	vapier.adi@gmail.com, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	John.Linn@xilinx.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, john.williams@petalogix.com,
	hpa@zytor.com, drepper@redhat.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "monstr" == monstr  <monstr@seznam.cz> writes:

 monstr> From: Michal Simek <monstr@monstr.eu>
 monstr> Signed-off-by: Michal Simek <monstr@monstr.eu>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

 monstr>  config SERIAL_UARTLITE
 monstr>  	tristate "Xilinx uartlite serial port support"
 monstr> -	depends on PPC32
 monstr> +	depends on PPC32 || MICROBLAZE
 monstr>  	select SERIAL_CORE
 monstr>  	help

-- 
Bye, Peter Korsgaard
