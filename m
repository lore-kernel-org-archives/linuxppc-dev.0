Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 3 Mar 2003 15:12:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>,
	Dan Malek <dan@embeddededge.com>
Cc: Ibon Gotxi Garcia <igotxi@jazzfree.com>,
	Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question about modules
Message-ID: <20030303221205.GA12414@ip68-0-152-218.tc.ph.cox.net>
References: <2702075D4DE2B043BF5EB82E9CFAD45B093BC7@mail1.mediatrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2702075D4DE2B043BF5EB82E9CFAD45B093BC7@mail1.mediatrix.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 28, 2003 at 01:27:26PM -0500, Jean-Denis Boyer wrote:

> > Everything works, till I try to insmod it: I get m8xx_cpm_alloc and
> > m8xx_cpm_hostalloc as unresolved symbols.
>
> In commproc.c, add the following line:
>   EXPORT_SYMBOL(m8xx_cpm_hostalloc);

I'll bite... Dan is there a good reason this isn't exported?  Google
shows nothing to me :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
