MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15213.42280.789880.989118@mediaone.net>
Date: Sun, 5 Aug 2001 15:57:28 -0400
From: R Shapiro <reshapiro@mediaone.net>
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: lcd17 kernel patches?
In-Reply-To: <20010805200639.A14938@suse.de>
References: <15213.15313.170106.433877@mediaone.net>
	<20010805200639.A14938@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Olaf Hering writes:
 > Try this one in the meantime:

OK, this mostly works with the 2.4.7 kernel sources, but there's one
important difference between the building a kernel this way and
running that prebuilt 2.4.2.  The prebuilt kernel has working video
immediately on booting.  The kernel I built with your patch has no
video at all until I run 'fbset 1280x1024-60'.  Clearly there's more
to that prebuilt 2.4.2 than just an additional mode definition.

But this will do for now - thanks for the patch.  I created an init.d
entry which runs the fbset command and I set it to run very early
(00).  So at least I can see some of the boot messages as they go by.
Maybe I could put it in inittab or rc.sysinit to get it even earlier.
But I might rather wait for a real patch.




--
reshapiro@mediaone.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
