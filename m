Date: Tue, 5 Oct 1999 20:40:16 -0400
From: Eric Dorland <dorland@lords.com>
To: Elliot Lee <sopwith@redhat.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
Message-ID: <19991005204016.A3979@HSE-MTL-ppp4439.qc.sympatico.ca>
References: <19991005105431.012853@mailhost.mipsys.com> <Pine.LNX.4.10.9910050733100.1006-100000@lacrosse.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.9910050733100.1006-100000@lacrosse.corp.redhat.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 05, 1999 at 07:36:19AM -0400, Elliot Lee wrote:
> In ftp://people.redhat.com/sopwith/esound-0.2.15.tar.gz (not a final
> release), it explicitly sets big-endian mode on big-endian machines, so
> things should work a bit better. There is also a related bug in the sound
> file playback code fixed, that should help davem's "esdplay plays garbage"
> problems. Please try this out and let me know.

Unfortunately, under my machine (G3/266 DT) this version works even more
poorly than the one I was using before. The startup beeps are now more like
startup hisses, and wavs (whether 8-bit or 16) sound like a bunch of
hissing. To compile it I just did a vanilla ./configure; make; make install
which seemed to be the right thing to do.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
