Date: Tue, 9 May 2000 11:47:43 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Martin Costabel <costabel@wanadoo.fr>
cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3.99-pre6 sound hfs
In-Reply-To: <3911DC0D.DE0C0C13@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10005091140370.13926-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > >From my personal mail archive, I see that HFS was already broken in
> > > 2.3.18 last September.
> >
> > And it got fixed enough to be working again at least in 2.3.48 - that fix
> > (or rather workaround) may have been broken again lately.
>
> This is a little mysterious. It looks almost as if HFS is working for
> some people and not for others.

I've done a few tests and it looks like HFS in 2.3.48 is still pretty
broken. Creating a subdirectory, or copying a file to any directory except
for the root directory on a small zip partition is sure to panic. Even on
my 300 MB IDE partition, only copying to the root directory works more or
less reliably. Creating a subdirectory worked, copying the first file to
it worked, copying the second panicked. Sorry for causing a bit of
confusion...

I'll try 2.3.99 with Ani's patch next :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
