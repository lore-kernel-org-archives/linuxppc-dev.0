Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 21 May 2004 12:23:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 CPM DP ram free function
Message-ID: <20040521192333.GI6763@smtp.west.cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DADE@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DADE@ismail.innsys.innovsys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 21, 2004 at 12:35:01PM -0500, Rune Torgersen wrote:

> It adds functionality to the 8260 CPM to free() allocated host and dp
> ram memory. (nice for loadable drivers that use DP ram)

First, when this has come up in the past, the first question is why is
this useful, given that with the hardware and peripherals in question,
loadable drivers aren't really useful (and don't shoot the messenger
please).

Second, you removed the EXPORT_SYMBOL for the old alloc, but I didn't
see quickly how a module would make use of the new infrastructure since
there weren't any new EXPORT_SYMBOLs.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
