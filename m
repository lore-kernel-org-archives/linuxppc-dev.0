Date: Sat, 14 Apr 2001 22:56:06 -0300
To: linuxppc-dev@lists.linuxppc.org
Subject: bk tree doesn't build because of cputable.h
Message-ID: <20010414225606.A7020@llama.nslug.ns.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Peter Cordes <peter@llama.nslug.ns.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 For some reason, the patch in
http://lists.linuxppc.org/listarcs/linuxppc-dev/200104/msg00130.html
 was applied to the bk tree.  (I rsync'ed against it from
penguinppc.org/linux-2.4-bk yesterday, and again today.)  cputable.h doesn't
exist in that tree, so it breaks when I try to build the kernel.  Removing
the #include makes the kernel build succeed.  Somebody should fix this. :>

 (please CC on reply, I'm not subscribed to the list.)

--
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@llama.nslug. , ns.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BCE

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
