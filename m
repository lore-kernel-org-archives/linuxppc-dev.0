Date: Mon, 10 Apr 2000 13:47:45 -0400 (EDT)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: Graham Stoney <greyham@research.canon.com.au>
cc: Jason Wohlgemuth <jsw-embedded@mindspring.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Unpacking the mvista kernel RPMs
In-Reply-To: <20000410045041.8530D3C960@elph.research.canon.com.au>
Message-ID: <Pine.LNX.4.21.0004101342080.3916-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

> Sure, this works, but it doesn't automagically apply the patches.
> Perhaps I'm just asking too much :-(.

You can install source rpm's and use "rpm -bp foo.spec" from
/usr/src/redhat/SPECS to "prepare" the sources. All the patches will be
applied. "man rpm" for details.

I agree that it would be nice to do it in one step from foo.src.rpm just
like "rpm -tp" works on tarballs. But the world is not perfect.

Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
