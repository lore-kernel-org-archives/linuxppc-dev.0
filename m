Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 9D68167A73
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 03:37:27 +1100 (EST)
Date: Thu, 17 Mar 2005 11:35:56 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050317163223.6C37EC1510@atlas.denx.de>
Message-ID: <Pine.LNX.4.61.0503171134230.22767@localhost.localdomain>
References: <20050317163223.6C37EC1510@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: looking for a model for building CRAMFS(?)-based system 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 17 Mar 2005, Wolfgang Denk wrote:

> Dear Robert,
>
> in message <Pine.LNX.4.61.0503171011220.20335@localhost.localdomain> you wrote:
> >
> > now this is the sticky part.  imagine this system out in the field,
> > where you need to make an update to something in the initrd in the
> > root filesystem.
>
> This is the szenario where an overly filesystem enters the stage.
>
> See http://www.denx.de/e/news.php#MINI_FO

i'd already read that paper a few months back, but wasn't sure if this
was actually being used, or was just a concept idea.  if it's actually
in practise, i'll take another look at it.

rday
