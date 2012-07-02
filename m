Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8F5F42C0086
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 20:21:41 +1000 (EST)
Date: Mon, 2 Jul 2012 12:21:34 +0200
From: Anatolij Gustschin <agust@denx.de>
To: stephan@gatzka.org
Subject: Re: MPC5200b jffs2 memcpy alignment problem
Message-ID: <20120702122134.50340f5f@wker>
In-Reply-To: <4FEFF265.3010102@gatzka.org>
References: <1341086991.2252.0@antares>
	<4FEFF265.3010102@gatzka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Albrecht =?ISO-8859-1?B?RHJl3w==?= <albrecht.dress@arcor.de>,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stephan,

On Sun, 01 Jul 2012 08:47:01 +0200
Stephan Gatzka <stephan@gatzka.org> wrote:

> Hi Albrecht,
> 
>  > I don't recall who proposed this patch, but exactly this solution is
>  > around for a longer time (mayby you search archives...).  On my board, I
>  > have a flash chip attached to the LocalBus in 16-bit mode.  Based on
>  > 3.2.16, the patch is:
> 
> Thanks for your answer and yes, this patch will definitely work. But I 
> want to have a solution in the mainline kernel, that's why I'm asking 
> how to deal best with this problem.

This problem has been discussed several times [1], [2], but wasn't
resolved yet. The clean solution suggested was to implement a custom
mapping driver [3].

Thanks,
Anatolij

[1] http://thread.gmane.org/gmane.linux.drivers.mtd/21521
[2] http://thread.gmane.org/gmane.linux.ports.ppc.embedded/36324
[3] http://thread.gmane.org/gmane.linux.ports.ppc.embedded/36324/focus=36608
