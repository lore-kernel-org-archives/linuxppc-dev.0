From: acurtis@directvinternet.com
Reply-To: <acurtis@directvinternet.com>
To: "Ppc Developers" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: asm-ppc/io.h - 8260 conditional compile?
Date: Tue, 6 Aug 2002 08:15:11 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFAEGLDKAA.acurtis@directvinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3D4FE40F.80802@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> No, it shouldn't.  The 4xx/8xx are unique because of the way they
> have to map memory in support of cache coherent (i.e. uncached)
> windows.  The 82xx processor family is a standard cache coherent 6xx
> core and doesn't require any special software support.

Thanks, it makes sense that it would be more Mac like because of the 6xx
core.

> > 8260 memory translations were broken in HHL 2.0 (Linux 2.4.2)
> Just making
> > sure it isn't still broken in 2.4.17

The big one that I remember is that iopa() was essentially a null function
because it was missing the CONFIG_8260 conditional.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
