Message-ID: <C08678384BE7D311B4D70004ACA371050B7632A8@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Linux on 857T?
Date: Mon, 21 Jan 2002 18:20:12 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am attempting a Linux port to a custom 857T board.  I've tried
several different kernel trees, with the same results:  unhandled
ITLB misses parking the CPU.  Now, I've searched repeatedly through
the mailing lists here, but haven't found the answer to the following:

	Has anyone has successfully ported Linux to an 857T?

I know many people have done it on 860's and 8260's, but I am curious
about any undocumented errata (perhaps MMU-related) that anyone may
have found, or any gotchas.

I am of course omitting, on this post, many specific details such as
kernel revisions, location of the CPU hang, specifics of the board,
what devices are on it, what hardware has been tested and how,
etc., etc.  At this point, I'd just like to know if anyone has
succeeded on an 857T at all; then, maybe we could discuss things in
more detail.

Thanks in advance ... .

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
