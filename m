Return-Path: <odie@cs.aau.dk>
Received: from smtp.cs.aau.dk (smtp.cs.aau.dk [130.225.194.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.cs.aau.dk", Issuer "LiteSSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3A972DDF15
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 05:38:37 +1100 (EST)
Subject: Re: [PATCH] Fix compilation of powerpc asm-offsets.c with old gcc
From: Simon Holm =?ISO-8859-1?Q?Th=F8gersen?= <odie@cs.aau.dk>
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20080208120623.3ad74e3a.pj@sgi.com>
References: <18347.34100.60973.215093@cargo.ozlabs.ibm.com>
	<alpine.LFD.1.00.0802071449240.2896@woody.linux-foundation.org>
	<20080208120623.3ad74e3a.pj@sgi.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 08 Feb 2008 19:31:04 +0100
Message-Id: <1202495464.6722.13.camel@odie.local>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>,
	tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


fre, 08 02 2008 kl. 12:06 -0600, skrev Paul Jackson:
> Linus wrote:
> > Please, when mentioning hex numbers, also do the one-liner shortlog.
> > ...
> > without _requiring_ people to be git users to get the gist of the 
> > matter, ok?
> 
> 
> Thanks for sticking up for us git-challenged contributors.
> 
> Can anyone point me at instructions providing the shortest
> path for getting from one of those git hex numbers to the
> log or change it represents, for non-git users?

Use gitweb [1], Linus' tree is here [2]. Just search for the hex.

[1] http://git.kernel.org/
[2]
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=summary


Simon Holm Thøgersen
