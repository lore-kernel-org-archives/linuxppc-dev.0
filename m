Message-ID: <3AFAC0BD.2C822E4E@mvista.com>
Date: Thu, 10 May 2001 12:24:29 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_5 source tree (and others)
References: <21780.989483882@msa.cmst.csiro.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Murray Jensen wrote:

> ......Could someone in the
> know please post a quick update what this means, and perhaps what the
> future holds wrt 2.4/2.5 linuxppc (embedded)?

Tom Rini has done lots of this work, so I'll rely on him to respond.
He is trying to finish up some finals at school, so it may take a day
or so.

> I guess I should actually ask about what I want :-) The linuxppc_2_5 tree
> had a "drivers/i2c/i2c-algo-8xx.c" file which has disappeared from 2_4_devel.

Right.  Tom is working with the real authors of the I2C software so
we get approval to just check this in all of the way to the main
kernel tree.  I was able to drop it into the _2_5 tree because I
didn't have to ask.  If you still have the _2_5 tree around, just
make a patch to 2.4_devel and keep on going.  It should show up for
real pretty soon.  I have also modified this for the 8260, and I
am going to have to look for it and get that checked in, too :-).
I still think bit-banging software for I2C is faster and more
efficient than using the CPM......at least for single master mode.

> And while I am at it, I have searched the archives for info about IDMA
> and it appears that it is a do it yourself job

Well, yes...Implicitly, all CPM devices use IDMA, so just copy one
of those and gut it for your own use.  All an IDMA driver would do is
set up buffer descriptors.  All of the device control and buffer
management is unique to the device, so I still can't grok a "generic"
IDMA driver.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
