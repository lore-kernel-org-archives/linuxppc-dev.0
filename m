Message-ID: <366A3B16.48093C74@ixl.com>
Date: Sun, 06 Dec 1998 02:06:46 -0600
From: jeramy <jsmith@ixl.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: EGCS 1.1.1 FYI
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cygnus released 1.1.1 on Dec. 1 with the following PPC specific
improvements.

Fixed PPC/RS6000 LEGITIMIZE_ADDRESS macro and bug in conversion from
unsigned ints to double precision floats. 
Fixed handling of long longs for varargs/stdarg functions on the ppc. 
Fixed code generation problems with gpr<->fpr copies for 64bit ppc. 
Makes sure target libraries build with -fPIC for PPC targets.

Good to see this much platform specific progress in a x.x.1 release. :)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
