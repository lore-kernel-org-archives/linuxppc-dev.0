Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 62AB0DDE05
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 17:29:48 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 32-bit kernel on PPC64 supported?
Date: Sat, 19 Jul 2008 09:29:42 +0200
References: <200807182043.08991.marvin24@gmx.de>
	<1216419275.7740.459.camel@pasglop>
In-Reply-To: <1216419275.7740.459.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807190929.42995.marvin24@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

On Saturday 19 July 2008 00:14:35 Benjamin Herrenschmidt wrote:
> On Fri, 2008-07-18 at 20:43 +0200, Marvin wrote:
> > Hi,
> >
> > while trying to cleanup some configs/makefiles for ppc64 I noticed, that
> > CONFIG_POWER4 implies CONFIG_PPC64 and vice versa in all defconfigs.
> > So I want to boldly replace CONFIG_POWER4 by CONFIG_PPC64 - ugh.
>
> No, those are different.
>
> CONFIG_PPC64 means a 64 bits kernel.
>
> CONFIG_POWER4 means a 64 bits kernel that only runs on IBM POWER4 and
> later (ie, processors conforming to, iirc, version 2.01 or later of
> the architecture).
>
> That is, it's legal to have CONFIG_PPC64 and !CONFIG_POWER4, and this
> is even necessary if you want to boot on a POWER3 or an RS64 processor.

I don't want to replace CONFIG_POWER4 by void, but by something like 
CONFIG_TUNE_POWER4 (see my previous post, one week ago). So there is 
no "feature loss". CONFIG_POWER3 is used only to define HAVE_BATS, so I 
thought I can clean this up. 

> Now, there also used to be some 32 bits support for POWER4 and G5 but
> that has been dropped a while ago.

Ok - that's fine. 

I hope to finish my patches during the weekend, so things will become more 
clear. 

Greetings

Marvin
