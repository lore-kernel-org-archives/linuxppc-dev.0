MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: TiBook, 1394, iPod working (sort of  ;-)
Date: Tue, 27 Nov 2001 09:02:40 +0100
Message-ID: <2C5637A6A7CE844EA3C0A94565479F520B4787@dest-as20-002.int.bauer-partner.com>
From: "Halfmann, Klaus" <Klaus.Halfmann@bauer-partner.com>
To: "Ira Weiny" <iweiny@acm.org>
Cc: "linuxppc" <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Ira, you wrote:

> 1) How are things with HFS+?  I don't know much but have done
> some poking around.  I notice that I can mount the iPod but the files
it
> shows are not correct.  But I have another HFS+ drive which seems to
mount
> ok?  I have looked at the volume info and have seen that the iPod
version in the
> volume header is "05" and the other drive is version "06"?  This seems
odd
> since I would think the earlier version would be better supported?
But I
> probably don't know what
> I am talking about...

HFS+ Volumes are wrapped in a HFS-structure for security reasons, you
can
find out about his at some Website at Apple.

I once started doing a set of HFS+ Tools but got stuck due to personal
reasons.
The current state is that _reading_ works and writing works a little
bit.
I'd be happy someone would care about these. There is a (rotten) tarball

at penguinppc.org. I use(d) a CVS Repository at SuSE. Since I just
upgraded
to SuSE 7.3 I might try to build it again.

In case you are interested feel free to contact me.

	Klaus Halfmann http://klaus.halfmann.bei.t-online.de
			   (Mh, I really should update this page)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
