From: Eric.Oosterhof@radisys.com
Subject: diff, patch, and symbolic links
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <OFD9450AAE.A65F3031-ON88256BA5.006340E2@radisys.com>
Date: Wed, 24 Apr 2002 11:07:00 -0700
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a customized kernel tree, and am trying to create the appropriate
patch file.  I use diff -ruN, and then subsequently use patch -p0 to apply
the patch.  When I apply the patch, the files that I have changed in the
include/asm-ppc directory cause conflicts with the include/asm symbolic
links to the same files.  I think that I can resolve this by editing the
patch file to remove any reference to changes in the include/asm tree, but
the exclude file that I created that listed all the include/asm files
should have worked.  At any rate, I am looking for the "right" solution.

Eric Oosterhof


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
