Message-ID: <399C69C1.AEF6646E@sympatico.ca>
Date: Thu, 17 Aug 2000 18:40:01 -0400
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Reply-To: khendricks@ivey.uwo.ca
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Nautilus builds and works from source on ppc
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

In case anyone is interested.  I upgraded a straight YDL CS 1.2 system with the
latest binutils, glibc, and gcc from Franz and installed the helix code and
updated it to the latest releases.

I then grabbed all of the required parts and followed the build instructions
from Eazel and shortly had a working Nautilus file manager (I did have to edit
one makefile in Nautilus to add the -lrpm library to one of the component view
tools but that is it.

It seems to build rather easily.  If it turns out to be stable I will build tar
archives for installation into /usr/local/ so other people can play with it.

Just let me know if you are interested.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
