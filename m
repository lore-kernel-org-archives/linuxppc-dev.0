Message-ID: <38981EBE.97B3CD6A@col.bsf.alcatel.fr>
Date: Wed, 02 Feb 2000 13:10:38 +0100
From: duyrat1 <duyrat1@col.bsf.alcatel.fr>
MIME-Version: 1.0
To: Dan Malek <dmalek@jlc.net>, linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Unhandled relocation of type 18
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hy,

I am working on a mpc860 with linux 2.2.12 and I use modutils-2.1.121
I have a problem when I try to load my module :
  >      insmod ca_kernel.o

ca_kernel.o: Unhandled relocation of type 18 for __gedf2
ca_kernel.o: Unhandled relocation of type 18 for __fixdfsi
ca_kernel.o: Unhandled relocation of type 18 for __adddf3
ca_kernel.o: Unhandled relocation of type 18 for __fixdfsi
ca_kernel.o: Unhandled relocation of type 18 for free
ca_kernel.o: Unhandled relocation of type 18 for malloc
ca_kernel.o: Unhandled relocation of type 18 for __builtin_new
ca_kernel.o: Unhandled relocation of type 18 for _exit
ca_kernel.o: Unhandled relocation of type 18 for __lshrdi3
ca_kernel.o: Unhandled relocation of type 18 for __lshrdi3
ca_kernel.o: Unhandled relocation of type 18 for __make_fp
ca_kernel.o: Unhandled relocation of type 18 for __make_dp

Does anyone understand why ?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
