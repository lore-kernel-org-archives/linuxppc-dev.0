Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: 8260 and skb implementation
Date: Tue, 7 May 2002 22:17:24 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFGEKKDGAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CD7F88A.5000205@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > We have an 8260 based product and have many production boards
> with pre-B.3
> > rev processors. As mentioned on this list, we had to modify all
> CP related
> > communications to operate from local RAM to avoid lock-up problems.
>
> I don't remember why you had to do this........

If you have another 60X bus master, such as a PowerSpan PCI controller, you
need to move all CP buffers and descriptors out of main memory or the CP
will freeze.

> > ....Has anyone
> > considered moving the SKB memory into local RAM as well? ....
>
> Yes, except I have never had a platform with a working local bus interface
> where this would work.

I do not know how to help you with hardware. I thought that the EST or
Tundra eval cards had local RAM. (However, we had cache problems with the
Tundra card.) Do you believe moving SKB to local RAM has merit? Any oppinion
about the impact on the zero-copy implementation?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
