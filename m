Date: Wed, 15 Sep 1999 15:47:02 -0700
From: "David N. Welton" <davidw@linuxcare.com>
To: linuxppc-dev@lists.linuxppc.org
Cc: sschoen@linuxcare.com
Subject: Re: New booter
Message-ID: <19990915154702.E26759@bassano.linuxcare.com>
References: <v04011701b404e6cd4493@[199.174.193.101]> <v04011701b404e6cd4493@[199.174.193.101]> <v03130302b40589d1f8f6@[17.202.21.235]> <v04210101b405cc106028@[192.168.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v04210101b405cc106028@[192.168.0.1]>; from Ethan Benson on Wed, Sep 15, 1999 at 02:27:30PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Speaking of booting stuff, I have an RS6000 F50 here, which I have got
running Yellowdog Linux.  To boot it, I currently use a floppy with
the 2.3.10 kernel.  Does anyone know how to go about booting these
things from the HD?  Various combinations of "boot scsci/sd@8,0...."
don't seem to have much effect on it, which seems logical, as the
kernel is on an ext2 partition.

Also, what is the best place to get the most recent devel kernels?
I'm interested in getting into some of the low level stuff on these
boxes, and want to start from where everyone else is.  I got 2.3.18 to
compile, but it doesn't do much after I boot it... seems to get out of
prom_init and then die somewhere, and I don't know much about getting
further information out of head.S (prom_init is in C and I can call
prom_print).

Anyway, anything people can tell me about this machine, the kernel,
etc, would be quite useful.

Thanks for your time,
-- 
David N. Welton, Developer, Linuxcare, Inc.
415.354.4878 x241 tel, 415.701.7457 fax
dwelton@linuxcare.com, http://www.linuxcare.com/
Linuxcare. At the center of Linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
