Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: incorrect defiition of _FPU_IEEE for ppc linux?
Date: Thu, 19 Apr 2001 08:21:19 -0400
MIME-Version: 1.0
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Message-Id: <01041908211903.25891@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I ran into a problem while porting OpenOffice 625 to ppc linux.  To turn off
exceptions under linux they set the fpu_control word to _FPU_IEEE.  This
works under x86 linux.

Under ppc linux, in fpu_control.h _FPU_IEEE sets the control word to
0x000000F0 which actually enables overflow, underflow, divide by zero,
and invalid fpu exceptions.  _FPU_DEFAULT actually disables them.

Isn't  fpu_control.h supplied by glibc?

If so, shouldn't  _FPU_IEEE be actually disabling fpu exceptions under ppc
linux and not enabling them?

Is this an issue in current glibc CVS too?

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
