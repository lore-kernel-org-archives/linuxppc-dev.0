Subject: Re: ptrace Problem
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Kent Borg <kentborg@borg.org>
Cc: Jean-Denis Boyer <jdboyer@m5t.com>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030715174945.G12505@borg.org>
References: <AB5AF73EAF23304EA1B932174137CED70303AE@m5tmail.m5t.com>
	<20030715174945.G12505@borg.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: 16 Jul 2003 12:37:51 +0200
Message-Id: <1058351871.31114.26.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2003-07-15 at 23:49, Kent Borg wrote:

> Looking at likely source tarballs we have sitting around it seems very
> likely that binutils were built from 2.13.2.1, and glibc 2.3.2.  (How
> can I be sure?)

binutils binaries usually respond with the version when given -V on the
command line.

libc can be checked with objdump -x and checking the Version
definitions.

This should not be a problem gdb dose all the work using ptrace.


Regarding your gdb problems have you tried with a kernel without bdi2000
support in the kernel.


--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 719 70 20
Tellusborgsvägen  90              Fax: +46 8 719 29 45
126 25 Stockholm                  ken@switchboard.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
