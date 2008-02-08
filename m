Return-Path: <harvey.harrison@gmail.com>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.247])
	by ozlabs.org (Postfix) with ESMTP id 2147BDDF62
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 05:20:32 +1100 (EST)
Received: by hs-out-2122.google.com with SMTP id x43so3924919hsb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 08 Feb 2008 10:20:31 -0800 (PST)
Subject: Re: [PATCH] Fix compilation of powerpc asm-offsets.c with old gcc
From: Harvey Harrison <harvey.harrison@gmail.com>
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20080208120623.3ad74e3a.pj@sgi.com>
References: <18347.34100.60973.215093@cargo.ozlabs.ibm.com>
	<alpine.LFD.1.00.0802071449240.2896@woody.linux-foundation.org>
	<20080208120623.3ad74e3a.pj@sgi.com>
Content-Type: text/plain
Date: Fri, 08 Feb 2008 10:20:26 -0800
Message-Id: <1202494826.31361.49.camel@brick>
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

On Fri, 2008-02-08 at 12:06 -0600, Paul Jackson wrote:
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
> 

Replace <SHA> as needed:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=<SHA>

Harvey
