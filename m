Return-Path: <jwboyer@gmail.com>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.241])
	by ozlabs.org (Postfix) with ESMTP id 73BABDDEC4
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 08:11:43 +1100 (EST)
Received: by hs-out-2122.google.com with SMTP id x43so839031hsb.9
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 13:11:42 -0800 (PST)
Date: Sat, 22 Dec 2007 15:11:36 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: Time for cell code reshuffle?
Message-ID: <20071222151136.1198f96d@hansolo.jdub.homelinux.org>
In-Reply-To: <1198357082.6686.5.camel@pasglop>
References: <200712211522.03841.arnd@arndb.de> <476BF67C.2030405@am.sony.com>
	<1198357082.6686.5.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 23 Dec 2007 07:58:02 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Fri, 2007-12-21 at 09:23 -0800, Geoff Levand wrote:
> > 
> > It seems platforms/cell should have the shared and/or generic code,
> > and the other
> > stuff moved into a new platform directory, but is it worth the
> > effort? 
> 
> No, platforms/xxx isn't supposed to be shared code. That's was syslib is
> for.

I think you mean sysdev?

josh
