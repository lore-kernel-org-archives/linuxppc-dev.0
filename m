MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14803.48934.472348.909959@esb.bbn.com>
Date: Thu, 28 Sep 2000 17:59:02 -0400
From: R Shapiro <rshapiro@bbn.com>
To: cl.en@gmx.net
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
In-Reply-To: <20000928233119.B334@olis.north.de>
References: <14803.24024.683420.911271@esb.bbn.com>
	<20000928233119.B334@olis.north.de>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Claus writes:
 > when you're in OF a 'devalias' should do it

It says the internal ide is /pci/mac-io/ide@20000.  Making this the
boot-device causes an instantaneous DEFAULT-CATCH.

I ran quik 1.3.1 in linux beforehand, with a reasonable quik.conf.
I'd rather have used the MacOS quik - that's always worked better for
me on other machines that boot this way.  But in this case it says
it's unable to write to the ide drive.  That was MacOS quik 1.3 - if
there's a 1.3.1 version for MacOS, I couldn't find it.


 > boot-device = ata0/ata-disk@0:x (x=root in hex,)

OF is "unable to open" any variant of this I could come up with.

Thanks anyway, but I guess this machine is stuck with BootX.

--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
