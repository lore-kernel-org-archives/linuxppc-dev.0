Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 2426E1007D8
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Dec 2009 05:35:57 +1100 (EST)
Date: Wed, 30 Dec 2009 21:35:56 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: nanda <nanda74pg@rediffmail.com>
Subject: Re: FSL UPM NAND driver for linux 2.6.24
Message-ID: <20091230183556.GA13890@oksana.dev.rtsoft.ru>
References: <20091230083656.51308.qmail@f5mail-237-241.rediffmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091230083656.51308.qmail@f5mail-237-241.rediffmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 30, 2009 at 08:36:56AM -0000, nanda wrote:
> Hi,
>    I am looking for freescale NAND driver in the kernel 2.6.24
> (which implement UPM based technique). Can anyone point us the
> patch which is available for the same?

There is drivers/mtd/nand/fsl_upm.c in the mainline kernel
(it's there since 2.6.26, IIRC).

Or are you looking for the ready to use back-port of that
driver? I don't have one, but it should be relatively easiy
to back-port.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
