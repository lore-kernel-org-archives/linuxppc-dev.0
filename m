Date: Mon, 31 Dec 2001 16:01:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bob Piatek <bobtek@fishcamp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: unresolved symbol
Message-ID: <20011231230158.GL28513@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011231153213.GB28513@cpe-24-221-152-185.az.sprintbbd.net> <000501c1924d$1fd40410$a2341204@P4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000501c1924d$1fd40410$a2341204@P4>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 31, 2001 at 02:47:28PM -0800, Bob Piatek wrote:

> Correct me if I'm wrong, but it looks like the problem is caused by the
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
