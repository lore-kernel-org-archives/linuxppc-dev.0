Date: Thu, 28 Oct 1999 21:22:21 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: 2.3.18 on openprojects.net
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9910282101200.3728-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Yesterday (99-10-27) evening I downloaded 2.3.18 and
tried to compile it. In order to succeed, I had to turn
ON CONFIG_MODULE, otherwise I am getting error with
EXPORT_SYMTAB_not_defined (I think it was in serial.c
but I am not sure).

Also, I am trying to had MATH_EMULATION but this fails
in math.c complaining about a structure not having a
member name tss (in current->tss). I tryied to follow
the definitinoa little bit ans found that current is
a struct task_struct but there is no member that has
the tss (a least not directly). I found many instances
(using fgrep) in many asm-PROCESSOR files (for i386,
MIPS, M68K, etc.) but nothing in asm-ppc. I guess
the task management fucntions is/are in some sort
of evolution and math_emu is not up to date. Is
somebody is working on it?


Claude


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
