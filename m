Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: 8260 and skb implementation
Date: Wed, 8 May 2002 07:18:23 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFCEKODGAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CD8BCF7.1090102@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> > ... Do you believe moving SKB to local RAM has merit?
>
> ...I don't think SK bufs will because of the high processor core access.

I am not sure what you are saying here?

> > ... Any oppinion
> > about the impact on the zero-copy implementation?
>
> We should make the change to the receive side so this happens.  The
> transmit doesn't copy.  I just copied the code from the 8xx long ago
> and never made the change.  We can't properly do zero copy receive
> on processors that don't have coherent caches due to alignment and
> other information potentially shared in a cache line.

You would think that alignment was a common implementation concern.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
