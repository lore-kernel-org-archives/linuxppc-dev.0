Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@lists.ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 01/15] [PS3] Add udbg driver using the PS3
	gelic Ethernet device
Date: Thu, 11 Aug 2011 14:13:51 +0200
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-2-git-send-email-a.heider@gmail.com>
	<4E39CC67.2060606@infradead.org>
In-Reply-To: <4E39CC67.2060606@infradead.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201108111413.51764.arnd@arndb.de>
Cc: Geoff Levand <geoff@infradead.org>, Andre Heider <a.heider@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 04 August 2011, Geoff Levand wrote:
> > + *
> > + * udbg debug output routine via GELIC UDP broadcasts
> > + * Copyright (C) 2010 Hector Martin <hector@marcansoft.com>
> > + * Copyright (C) 2011 Andre Heider <a.heider@gmail.com>
> 
> Some of this seems to be taken from the gelic driver, so shouldn't
> the copyright info from there be included here?

Moreover, if there is a significant amount of code duplication
between this driver and gelic, I would expect to actually share
the code instead, either by integrating the udbg code into the
gelic driver in form of netconsole support, or by moving the
common parts into a separate module.

	Arnd
