Subject: RE: ptrace Problem
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 15 Jul 2003 12:30:26 -0400
Message-ID: <AB5AF73EAF23304EA1B932174137CED70303AE@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: "Kent Borg" <kentborg@borg.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kent, here are some ideas...

> The kernel is 2.4.21-rc1 with stuff done to it to support some
> hardware that is under development (the chip has a 603-style core).

Which chip is it?  Is it correctly recognized by the kernel (arch/ppc/kernel/cputable.c)? If not, it will choose a "Generic PPC", which might not have the correct attributes (for example, if it is a 8270, I think it is currently not recognized; the kernel would boot but the MMU would behave badly).

> Once this happens my Abatron BDI-2000 is somehow hosed and can no
> longer write to memory.  My next download takes all the time I would
> expect, but the results are all 0x0 unless I first powercycle the
> Abatron.

This is a silly question, but, did you try to unplug the BDI-2000 before running gdbserver? Just in case it stops on some exceptions...

> I have tried changing from our previous gdb and gdbserver
> to the Denx versions with same results.

Do you use a somewhat recent version of glibc, and was it built against a somewhat recent version of kernel? Can you also tell us the version of binutils and gcc ? Not all the combinations are reliable ;-)

Regards,
--------------------------------------------
 Jean-Denis Boyer, Eng.
 Software Designer
 M5T Centre d'Excellence en Télécom Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
