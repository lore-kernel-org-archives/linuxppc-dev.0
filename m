Date: Tue, 24 Oct 2000 21:29:20 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ThinkPad 850 Patches for 2.2.16
Message-ID: <20001024212920.A23705@suse.de>
References: <20001024200338.A908@suse.de> <19340918125404.28619@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19340918125404.28619@192.168.1.10>; from bh40@calva.net on Tue, Oct 24, 2000 at 09:22:20PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 24, Benjamin Herrenschmidt wrote:


> I beleive you must have a way to probe for the machine type and do the
> right thing, don't you ?

We need it, but not in arch/ppc :)
The cs4232.c driver has already some interrupt stuff that you can adjust
in .config. But we know the needed values so we could hardcode it in the
driver itself.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
