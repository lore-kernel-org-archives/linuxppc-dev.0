From: "Kim, Kwansuk" <kskim@neowave.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: The maximum size of stack in linuxppc kernel
Date: Fri, 19 Apr 2002 20:38:47 +0900
Message-ID: <OMENKEONFDLIGLHPFALBMELMCIAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
In-Reply-To: 
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, everyone,

I'm writing a device driver on my PPC405GP custom board, and

I wonder the maximum size of stack which is used for function call.

I searched kernel_source/Documantation and found such a comment.

     A rigid stack limit
      The kernel stack is about 6K in 2.2 (for most
      architectures: it's about 14K on the Alpha), and shared
      with interrupts so you can't use it all.  Avoid deep
      recursion and huge local arrays on the stack (allocate
      them dynamically instead).

But I wonder exact maximum size of the kernel I'm using (2.4.18-pre7)

How can I find it in the kernel source?

I wish you a nice weekend!

 ==============================================
     Just for fun...
                                                  - Linus Torvalds
 ==============================================
  Kwansuk Kim
  Engineer, NeoWave Inc.
  Tel   +82-31-380-4927    Fax +82-31-380-4747
  E-mail: kskim@neowave.co.kr
==============================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
