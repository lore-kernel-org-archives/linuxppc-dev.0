Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 7917DDE051
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Feb 2008 00:19:03 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1342927pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Feb 2008 05:19:01 -0800 (PST)
Date: Sun, 17 Feb 2008 07:18:51 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Sequoia NAND
Message-ID: <20080217071851.0edbf07f@vader.jdub.homelinux.org>
In-Reply-To: <20080217113932.02EBDDE127@ozlabs.org>
References: <20080217113932.02EBDDE127@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 17 Feb 2008 06:39:43 -0500
Steve Heflin <sheflin@newagemicro.com> wrote:

> I don't see where the new powerpc architecture and drivers/mtd/nand 
> contains support for the NAND chip on the Sequoia platform.  We have 

It's not.

> Is the Sequoia's NAND Flash Controller supported in the current Linux-2.6.25?

No.

There are a couple different patches floating around for it, all of
which need work.  The driver is drivers/mtd/nand/ndfc.c and work needs
to be done to parse a device tree and present the proper platform
devices so that driver will work.  Stefan has something like this
somewhere, I've just been lax in getting it into my tree.

Too late for .25, but I have 4 boards that use this now so I'll be a
bit more interested in getting it into .26.

josh
