Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 29299DE011
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 22:32:23 +1000 (EST)
Date: Fri, 25 Apr 2008 16:32:21 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] add gpiolib support for mpc5200
Message-ID: <20080425123221.GA27807@polina.dev.rtsoft.ru>
References: <20080424153659.GJ6692@pengutronix.de>
	<fa686aa40804241145x39165ffp78108c53d0d5a911@mail.gmail.com>
	<20080425105333.GM6692@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080425105333.GM6692@pengutronix.de>
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

On Fri, Apr 25, 2008 at 12:53:33PM +0200, Sascha Hauer wrote:
[...]
> > 
> > As for the wide spans caused by gpt gpios, it is probably okay for
> > now, but we can rework it to do something clever (like have a single
> > registration for all gpt gpios) at a later date.
> 
> I would rather teach the of gpio infrastructure not to reserve 32 gpios
> for each chip. This will bite us once we want to support gpio chips with
> more than 32 gpios anyway.

The patch already exists:
http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052881.html

It is waiting for few patches that are in the -mm tree (Andrew said that
he'll push them into 2.6.26 at some point).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
