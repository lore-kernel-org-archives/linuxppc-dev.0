Message-ID: <381696C9.43512555@fadata.bg>
Date: Wed, 27 Oct 1999 09:08:09 +0300
From: "Momchil 'Velco' Velikov" <velco@fadata.bg>
Reply-To: velco@fadata.bg
MIME-Version: 1.0
To: Bob Toxen <bob@roger.realminfo.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Nested stdarg broken?
References: <199910262303.TAA26743@roger.realminfo.com>
Content-Type: text/plain; charset=koi8-r
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bob Toxen wrote:
> 
> My application uses stdarg (#include <stdarg.h>, va_start, and friends)
> in a function that then calls vfprintf which also uses stdarg.
> 
> The variable args get garbled by the time they get to vfprintf.  The
> fmt arg does not get garbled.
Here's what you can read at
http://egcs.cygnus.com/gcc-2.95/gcc-2.95.1.html
under section "Platform specific bugfixes and improvements"
         Fix varargs/stdarg code generation bug for rs6000/ppc svr4
targets. 
Maybe this helps, maybe not.

Regards,
-velco

btw, 2.95.2 is out

-velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
