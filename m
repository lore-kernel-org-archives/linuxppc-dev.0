Message-Id: <200212191610.RAA21095@ipnmail.in2p3.fr>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Xavier Grave <grave@ipno.in2p3.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: mmap problem with personnal code driver
Date: Thu, 19 Dec 2002 17:18:52 +0100
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I have written a driver for a pci to vme bridge and I have the following
problem : when I try to mmap some pci space to the user memory read is ok but
write seems broken on ppc arch. (it run without problem on x86 arch).

I think the problem is in the pgprot_val(vma->vm_page_prot) value.

I wonder if I haven't see something about that in the list before but I
couldn't find it for the moment.
Does anyone have an idea to help me ? :-)

xavier
PS: for people interested in the vme driver the new version support both
rtlinux, rtai and standard linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
