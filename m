Message-ID: <3965D59C.BC1BAC93@vnet.ibm.com>
Date: Fri, 07 Jul 2000 08:05:32 -0500
From: Tom Gall <tom_gall@vnet.ibm.com>
MIME-Version: 1.0
To: yellowdog-devel@lists.yellowdoglinux.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Changing default partition type for linux/ppc
References: <20000707105915.30418@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> Hi all !

Greets!

> So I suggest moving to Linux_ext2, Linux_swap, or maybe simply Linux and
> Linux_swap (since ext2 is not the only filesystem Linux may put on
> these). Using a different type for swap would help avoiding confusion.

I agree. I think this is a good step. However there's the obvious interoperability
problems with MacOS, OS X etc... Hopefully Apple's OSes wouldn't do anything evil
to the partition they don't recognize.

Regards,

Tom

Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
