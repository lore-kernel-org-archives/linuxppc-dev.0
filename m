From: Pete Buechler <peterb@suse.com>
Reply-To: Pete Buechler <peterb@suse.com>
To: Ruedi.Hofer@ascom.ch, linuxppc-embedded@lists.linuxppc.org
Subject: Re: newlib, uclib
Date: Thu, 6 Jul 2000 07:59:48 -0700
Content-Type: text/plain
Cc: distribution@linux01.hasler.ascom.ch
References: <0FXA0055X023NC@pmdf-it.hasler.ascom.ch>
In-Reply-To: <0FXA0055X023NC@pmdf-it.hasler.ascom.ch>
MIME-Version: 1.0
Message-Id: <00070608033801.21103@CX579290-B>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 06 Jul 2000, Ruedi.Hofer@ascom.ch wrote:
>
> Hi
>
> In order to build a commercially successful product I have to reduce the footprint of the system.
> Having a quick look at the files showed me, that the largest files are the libs (libc.so.6 = 4M) ... as u all know.
> When searching the web for replacements, I came across newlib and uclib.
>
> Is anyone out there who has done some work with this libs?
>
>  Are they easy to use, install, build?
>
> Are there other (small) replacements for the libc?
>
> /Ruedi
>

4M sounds like the unstripped size. Make sure you strip the symbols from the
libraries if you are desperate for disk space. Newlib is an implementation of
the C library, but it was intended for use on embedded systems without Linux.
Hence there is no support for the Linux system calls in it.

Another option is to identify the C library functions that you are actually
using and remove the others from the archive. That would be rather tough by
hand. Lineo has a closed source tool called "Lipo" which will do that for you -
there may be a free replacement in the works somewhere.

--
Pete Buechler	: SuSE Linux Developer
Work e-mail	: peterb@suse.com
Work web page	: http://www.suse.com/~peterb
Personal e-mail	: peter.buechler@home.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
