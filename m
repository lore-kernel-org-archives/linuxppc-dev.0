Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 76269DDF11
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 13:53:19 +1100 (EST)
Date: Wed, 13 Feb 2008 13:51:00 +1100
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] FIx compile of swim3 as module
Message-ID: <20080213025100.GY6887@bakeyournoodle.com>
References: <20080213024019.GX6887@bakeyournoodle.com>
	<20080212204802.18a7a868@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080212204802.18a7a868@zod.rchland.ibm.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, kyle@mcmartin.ca,
	LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 12, 2008 at 08:48:02PM -0600, Josh Boyer wrote:

> Kyle posted a slightly different patch that seemed to still keep
> the original intention of ifdefery in tact.  I've no idea which is
> better, but the three of you might want to compare notes.

/me checks ....

Hmm Kyle's seem the leave the:
#ifndef CONFIG_PMAC_MEDIABAY
#define check_media_bay(which, what)	1
#endif

in swim3.c, which doesn't seem right.

But I'm easy as long as it gets fixed. :)

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
