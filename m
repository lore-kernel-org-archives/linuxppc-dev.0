Message-ID: <20020805230054.71397.qmail@web40207.mail.yahoo.com>
Date: Mon, 5 Aug 2002 16:00:54 -0700 (PDT)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: debugging kernel modules
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang has a nice tutorial on this:
http://www.denx.de/doc/TQM8xxL/debugging.html

But here's the question - is there any way to dump the
module load addresses, after the fact?  'insmod -m'
works well if you always remember to use it to load
the module.  FreeBSD has 'kldstat' which dumps module
address information at any time.  Is there anything
similar to kldstat for linux?  If not, any comments on
how hard it would be to write one?

-Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
