Date: Sun, 7 May 2000 16:37:47 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: ian reinhart geiser <geiseri@msoe.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems Compileing PVM
In-Reply-To: <Pine.LNX.4.10.10005061706360.6831-100000@sleepchamber.apt5.msoe.edu>
Message-ID: <Pine.LNX.4.10.10005071634240.5834-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> __va_arg_type_violation
>
> 	It looks like a linker error...

No, it rather is a varargs usage error (illegal types used in va_arg()
calls). Sloppy programming is the cause of this, most likely.

If it makes you feel better: the error message goes away if you compile
without optimization. Doesn't mean the code will run, then.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
