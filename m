Date: Thu, 25 Nov 1999 01:53:32 -0500
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: dead code removal
Message-ID: <19991125015332.A22068@drow.res.cmu.edu>
References: <383C8C6B.97F4CF60@kerbango.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <383C8C6B.97F4CF60@kerbango.com>; from reekes@kerbango.com on Wed, Nov 24, 1999 at 05:10:03PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


That kind of stripping can not be done by the compiler.  It could
theoretically be done by the linker, and there MIGHT be a linker option
to give the warnings you want - what if another object file in your
program called DummyFunc?  Or worse, what if a shared library expected
DummyFunc to be available?


On Wed, Nov 24, 1999 at 05:10:03PM -0800, Jim Reekes wrote:
> 
> I have a little program that contains a routine DummyFunc() which is
> never reference in the code. Building this single source file in any way
> I've tried results in a binary which contains DummyFunc(). Using nm and
> objdump, as far as I can determine GCC 2.95 does not dead-code strip.
> (which I find amazing!). So I have two questions.
> 
> Am I missing something and GCC actually does dead-code stripping?
> 
>  - or - 
> 
> How can I find unused/unreferenced symbols in my code so that I can bury
> the dead code manually?
> 
> 
> Jim
> 
> P.S. I have always compared programming to ditch digging, and now I'm
> convinced.
> 


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
