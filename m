Message-ID: <398D1784.C68FB92E@gnu.org>
Date: Sun, 06 Aug 2000 17:45:08 +1000
From: Andrew Clausen <clausen@gnu.org>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        GNU Parted list <parted@gnu.org>
Subject: Parted 1.3.0-pre7, Mac support :-)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I've uploaded Parted 1.3.0-pre7 to:

	ftp://ftp.gnu.org/gnu/parted/devel/parted-1.3.0-pre7.tar.gz

I've successfully resized 1 "real life" ext2 partition on a macintosh,
with a mac disk label.  e2fsck didn't complain afterwards :-)

As you can see, it has had practically no testing, so don't use it
unless you're expecting ready to lose lots of data...

I've received lots of help from linuxppc people (in particular
Benjamin Herrenschmidt) - thanks everyone!

Andrew Clausen

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
