Message-ID: <3C9982AD.5030502@embeddededge.com>
Date: Thu, 21 Mar 2002 01:50:21 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <22654.1016673065@msa.cmst.csiro.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Murray Jensen wrote:

> I like this idea (a lot), but I'm not sure you were serious.

I'm always serious :-).

> .... The problem with
> this method starts when you have a lot of information to pass

I'm going to (constantly :-) argue that if you are passing lots of information
then something isn't designed correctly.  It's one thing to be passing a few
hardware hints or small configuration values, but I think it's quite wrong
to design a bunch of dynamic software that requires a small data base to be
passed into to the kernel.  Please don't be confused by this comment and start
aruging OF device trees on Macs.  The OF tree is really just a bunch of small
configuration items that allows lots of generic software to run on a variety of
Mac platforms.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
