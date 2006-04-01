Return-Path: <dstn@cs.toronto.edu>
Received: from cliff.cs.toronto.edu (cliff.cs.toronto.edu [128.100.3.120])
	by ozlabs.org (Postfix) with ESMTP id 4C8F0679E9
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Apr 2006 02:18:39 +1000 (EST)
Received: from monte.ai (monte.ai.toronto.edu [128.100.5.22])
	by cliff.cs.toronto.edu (Postfix) with ESMTP id CD7715FD03
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 11:18:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by monte.ai (Postfix) with ESMTP id C3B1631401
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 11:18:36 -0500 (EST)
Date: Sat, 1 Apr 2006 11:18:36 -0500 (EST)
From: Dustin Lang <dstn@cs.toronto.edu>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: suspend2 on PowerBook: keyboard doesn't work on resume [now it
	does!]
In-Reply-To: <1142232047.4228.1.camel@quad.lan>
Message-ID: <Pine.LNX.4.58.0604011108240.2100@monte.ai>
References: <Pine.LNX.4.58.0603112043460.25986@monte.ai>
	<1142232047.4228.1.camel@quad.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

To follow up on my previous post: after upgrading to suspend2.2.2 and
kernel 2.6.16.1, suspend/resume works perfectly on my PowerBook.

(I was just getting ready to do some kernel hacking to figure out why it
didn't work, and was pleasantly surprised to find that it did work!)

Cheers,
dstn.
