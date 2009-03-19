Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 0C673DDF7D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 00:41:15 +1100 (EST)
Date: Thu, 19 Mar 2009 16:41:13 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: TOMARI Hisanobu <posco.grubb@gmail.com>
Subject: Re: IDE cable detection on Apple PowerBook
Message-ID: <20090319134113.GA31953@oksana.dev.rtsoft.ru>
References: <20090318140638.e6b61eaa.posco.grubb@gmail.com>
	<1237363097.25062.345.camel@pasglop>
	<20090318224726.5cf83e23.posco.grubb@gmail.com>
	<1237442846.25062.466.camel@pasglop>
	<1237442917.25062.467.camel@pasglop>
	<20090319223001.c2674366.posco.grubb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090319223001.c2674366.posco.grubb@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 19, 2009 at 10:30:01PM +0900, TOMARI Hisanobu wrote:
> Thanks for helpful advices.
> This patch adds an option to drivers/ide/Kconfig and adds 
> some lines to drivers/ide/pmac.c .

I think it would be better to make it a kernel command line option
instead of Kconfig knob.

The reason is: with distro (pre-compiled) kernels you don't have to
re-compile anything to make the drive work.

The other option is to enable BLK_DEV_IDE_PMAC_SHORTCABLE by default,
but I'm not sure if it's safe thing to do (most probably not).

Thanks for you work on this,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
