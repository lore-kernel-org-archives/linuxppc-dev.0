Message-ID: <36C333CF.C652C208@pop.agri.ch>
Date: Thu, 11 Feb 1999 20:47:29 +0100
From: Andreas Tobler <toa@pop.agri.ch>
MIME-Version: 1.0
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: passing option to makefile via RPM-Spec
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I try to build egcs-1.1.1-1c under pre-R5 with the make option
'-fno-vtable-thunks'. I use the egcs-1.1.1-1c.src.rpm from biggi. 
As Franz Sirl suggested I inserted in the RPM-SPEC file from egcs the
following entry:


cd %{OBJDIR}
CFLAGS="-O2 -g -fno-vtable-thunks" <--- this I entered!!!
$RPM_BUILD_DIR/egcs-$RPM_PACKAGE_VERSION/configure -v --prefix=/usr \
        --enable-shared --enable-threads \
        $RPM_ARCH-redhat-linux

But I can't find the entry somewhere in my build.log. And for me it seems that
there was no success passing this option to the configure/make file of egcs.
Any hints?

Another question, how can I tell the egcs specs not to build the whole egcs,
only c and c++? It's a bit funny to wait about four and a half hour for
testing the compiler. (It's a 7200/90 which needs 4 1/2 hours to build egcs-1.1.1)


Thanks 
Andreas
-- 
------------------
| Andreas Tobler								
| CH-8004 Zuerich	
| E-mail: toa@pop.agri.ch		
------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
