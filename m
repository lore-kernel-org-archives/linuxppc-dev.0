Date: Fri, 7 Jul 2000 15:28:06 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Gall <tom_gall@vnet.ibm.com>
Cc: yellowdog-devel@lists.yellowdoglinux.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Changing default partition type for linux/ppc
Message-ID: <20000707152806.E12840@suse.de>
References: <20000707105915.30418@mailhost.mipsys.com> <3965D59C.BC1BAC93@vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3965D59C.BC1BAC93@vnet.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 07, Tom Gall wrote:

>
> Benjamin Herrenschmidt wrote:
>
> > Hi all !
>
> Greets!
>
> > So I suggest moving to Linux_ext2, Linux_swap, or maybe simply Linux and
> > Linux_swap (since ext2 is not the only filesystem Linux may put on
> > these). Using a different type for swap would help avoiding confusion.
>
> I agree. I think this is a good step. However there's the obvious interoperability
> problems with MacOS, OS X etc... Hopefully Apple's OSes wouldn't do anything evil
> to the partition they don't recognize.

As someone real important said a couple of weeks ago:
Don't trust them.


You know the slogan of Apple ;)



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
