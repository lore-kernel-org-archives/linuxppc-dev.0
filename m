From: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>
Message-Id: <199909210408.VAA04162@falcon.csc.calpoly.edu>
Subject: undefined references in vger 2.3 tree
To: linuxppc-dev@lists.linuxppc.org (linuxdev)
Date: Mon, 20 Sep 1999 21:08:48 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am I missing something?

swim3.o(.text+0x218): undefined reference to `check_media_bay'

etc...

This is not the only symbol which I have had trouble with but this is the first
one I could NOT do without?

I used my old config file from 2.2.12 and did gmake oldconfig so I suppose I
could have a config problem but.

Thanks
Ira Weiny


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
