Date: Thu, 16 Mar 2000 10:56:03 -0800 (PST)
From: howarth@bromo.med.uc.edu (Jack Howarth)
Message-Id: <200003161856.KAA17949@bromo.med.uc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: asm/types.h
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


     Is someone preparing a patch to the asm/types.h header for
asm-ppc in Linux 2.3.5x? The current header is too restrictive
with an unnecessary ifdef on __ASSEMBLY__ which prevents __u32
,etc from being declared. This breaks the build of XFree86 4.0.
Other platforms do not appear to have this ifdef on __ASSEMBLY__
and 2.2.15 doesn't for the ppc. Thanks in advance.
                  Jack

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
