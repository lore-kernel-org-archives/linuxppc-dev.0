Date: Sat, 11 Dec 1999 20:15:16 -0700 (MST)
From: Dan Burcaw <dburcaw@terraplex.com>
To: Hollis Blanchard <hollis+@andrew.cmu.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: DriveSetup 1.8.1?
In-Reply-To: <Pine.LNX.3.96L.991211220127.12367H-100000@unix47.andrew.cmu.edu>
Message-ID: <Pine.LNX.4.10.9912112013490.14591-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis,
> 
> So what's the story with the new DriveSetup, anyways? It used to make screwed up
> partitions, but that was going to be fixed. Has it been? Or was that just the
> Mac OS 9 IDE driver problem in the first place?
> 
> I haven't heard any definative answer on this - does anyone know?

The current Drive Setup, while having various Linux options, does not do
the right thing. The next version (1.8.3 I *think*) will be fixed. (and
won't setup /opt by default, for example, since that is really not
necessary)


Regards,
Dan

Terra Soft Solutions, Inc.
   Yellow Dog Linux
   "The Ultimate Companion for a Dedicated Server"
   http://www.yellowdoglinux.com/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
