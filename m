Message-ID: <008301c15225$06bb99b0$d8020101@aztec.local>
From: "Frederic Soulier" <soulier@aztec-radiomedia.com>
To: "Rudolf Ladyzhenskii" <rudolf.ladyzhenskii@act-aus.net>,
	"PPC-Linux list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
References: <619D608DD3F0D311882C009027732E1A83626C@ntserver.act.domain>
Subject: Re: Numbering of system calls
Date: Thu, 11 Oct 2001 09:19:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry for my last "very interesting" message...

> Kernel crashes and, among other things, it shows "Last syscall: 4".
> How can I relate that to actual syscall being executed?

This is related to the last syscall executed by the current thread.
Have a look at $KERNELDIR/arch/ppc/kernel/process.c

For the corresponding system call you should look at the
$KERNELDIR/include/asm-ppc/unistd.h (or $KERNELDIR/arch/ppc/kernel/misc.S),
the 4th syscall is "write".

Regards,

Fred

---
     Frederic Soulier    -    Aztec Radiomedia  /  Digigram Europe
  31, rue du chemin de fer,  F-67087 Strasbourg Cedex 2, France
   Phone : +33 (0) 3 88 30 90 90  /  Fax : +33 (0) 3 88 30 90 99
                     Web site : http://www.digigram.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
