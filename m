Date: Wed, 29 Mar 2000 17:40:34 -0800 (PST)
From: howarth@bromo.med.uc.edu (Jack Howarth)
Message-Id: <200003300140.RAA40714@bromo.med.uc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: MesaLibs srpm for XFree86 4.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
    For those bleeding edge XFree86 4.0 users out there I
have created an srpm which will build and install those
portions of Mesa like src-glu and src-glut that are not
part of the Mesa included in XFree86. The srpm will
build against the installed GL and not that in the Mesa
tarball and is based on the RedHat 6.2 Mesa 3.2 srpm.
The srpm, MesaLibs-3.2-1.src.rpm, can be gotten from
a link on my web page at <http://entropy.crashing.org/~howarth>.
Let me know if any programs that worked under the Mesa 3.x
rpms with XFree86 3.3.6 break under the XFree86 4.0/MesaLibs
combination. Oh the reflect demo in the demos directory
of the build tree is quite impressive on a G4.
                   Jack

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
