From: "Bob Piatek" <bobtek@fishcamp.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: "'Tom Rini'" <trini@kernel.crashing.org>
Subject: RE: unresolved symbol
Date: Mon, 31 Dec 2001 16:47:30 -0800
Message-ID: <000601c1925d$e4bcd940$a2341204@P4>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20011231230158.GL28513@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


OK. I updated the modutils package and that fixed it!  Thanks so much.

Bob

fishcamp engineering
105 W. Clark Ave
Orcutt, CA  93455
TEL: 805-937-6365
FAX: 805-937-6252


-----Original Message-----
From: Tom Rini [mailto:tmrini@cpe-24-221-152-185.az.sprintbbd.net] On
Behalf Of Tom Rini
Sent: Monday, December 31, 2001 3:02 PM
To: Bob Piatek
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: unresolved symbol

On Mon, Dec 31, 2001 at 02:47:28PM -0800, Bob Piatek wrote:

> Correct me if I'm wrong, but it looks like the problem is caused by
the
> kernel not exporting the symbols that are needed by the module and not
> in the actual module itself.  Is it that I built the kernel wrong
> somehow, or maybe the libraries in 'simple-ramdisk' image aren't
> sufficient, or is it something else?

Well, the kernel knows about its symbols at compile time, based on stuff
from the modutils program.  So, if you have a bad/missing genksyms
program, you won't get any symbols.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
