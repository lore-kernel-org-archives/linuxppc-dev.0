Message-ID: <A60FFE6CA339C742BE11C311EA8BFF540163D8@mdsms2.inside.mdsroc.com>
From: "Ruhland, Paul" <PRuhland@microwavedata.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: RE: diff, patch, and symbolic links
Date: Wed, 24 Apr 2002 14:18:07 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Eric,

I always do a 'make mrproper' and then an 'rm -f .config*' ( from the root
of the linux tree of course ) before generating any patch files.  Just be
sure to save your '.config' somewhere before you remove it.

This way all generated files including the 'include/asm' symlink are
removed.

--
Paul Ruhland


-----Original Message-----
From: Eric.Oosterhof@radisys.com [mailto:Eric.Oosterhof@radisys.com]
Sent: Wednesday, April 24, 2002 2:07 PM
To: linuxppc-dev@lists.linuxppc.org
Subject: diff, patch, and symbolic links



I have a customized kernel tree, and am trying to create the appropriate
patch file.  I use diff -ruN, and then subsequently use patch -p0 to apply
the patch.  When I apply the patch, the files that I have changed in the
include/asm-ppc directory cause conflicts with the include/asm symbolic
links to the same files.  I think that I can resolve this by editing the
patch file to remove any reference to changes in the include/asm tree, but
the exclude file that I created that listed all the include/asm files should
have worked.  At any rate, I am looking for the "right" solution.

Eric Oosterhof


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
