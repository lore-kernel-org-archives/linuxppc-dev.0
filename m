Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011701b4bd3df5e356@[204.210.50.184]>
In-Reply-To: 
 <Pine.LNX.4.10.10002011737470.13730-100000@darkmane.w-link.net>
References: 
 <Pine.LNX.4.21.0002011142420.26593-100000@adsl-78-160-189.gnv.bellsouth.ne
 t>
Date: Tue, 1 Feb 2000 18:01:14 -0800
To: darkmane@w-link.net
From: Greg Noel <GregNoel@san.rr.com>
Subject: Re: Problem running -O2 compiled Mozilla
Cc: phandel@cise.ufl.edu, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 5:41 PM -0800 2/1/00, Sean Chitwood wrote:
>I have been having problems w/ just plain compiling the mozilla source
>It compiles fine, but SEGFAULTS when I try to run it. I even tried going
>back to the M13 Source tree, not luck. Any hints? I was able to compile
>it and get it to run about a week before M13.

What's your version of glibc?  If it isn't 2.1.3, you'll need to upgrade.
Dynamic loading in versions earlier than 2.1.3 isn't fully thread-safe, and
mozilla tickles those bugs.

Hope this helps,
-- Greg Noel, retired UNIX guru

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
