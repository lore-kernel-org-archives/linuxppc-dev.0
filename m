Date: Tue, 8 Dec 1998 01:59:10 -0500
From: Daniel Jacobowitz <drow@cs.cmu.edu>
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EGCS 1.1.1 FYI
Message-ID: <19981208015910.A18662@drow.res.cmu.edu>
References: <schinder@pobox.com> <199812071128.GAA01786@smtp2.mindspring.com> <9812071511.AA34514@marc.watson.ibm.com> <13932.21810.162591.80793@onyx.nowhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13932.21810.162591.80793@onyx.nowhere.net>; from Ralf Weidemann on Mon, Dec 07, 1998 at 11:22:42PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 07, 1998 at 11:22:42PM +0100, Ralf Weidemann wrote:
> 
> >>>>> "David" == David Edelsohn <dje@watson.ibm.com> writes:
> >>>>> "Paul J Schinder" writes:
>     Paul> So are Gary Thomas' patches still necessary?
> 
>     David> 	The trampoline patch now has become a shared library
>     David> compatibility issue for glibc-1.99 support.  It only is
>     David> necessary until LinuxPPC cuts over to glibc-2.1 which will
>     David> require other binary incompatible changes at the same time.
> 
> Can someone clarify where the problem is exact with native
> egcs and libc-1.99 ? I use egcs-1.1.1 since the weekend and
> it seems to work fine. I had no trouble to build some shared
> lib stuff like in the latest jade or sgml-tools. This packages
> didn't compile with older version I tried (also Gary's egcs-1.1b),
> but that were generell compiler issues, I think.
> 
> But on the other side I also tried to run the SeaMonkeyBrowser
> (Mozilla) from recent cvs-sources. Building went fine, but the
> beast didn't run. I get only a simple "Aborted" message on the
> console and it seems to crash somewhere in the startup code.
> So maybe this is somehow related ?
> 
> Had someone luck to run a recent version of Mozilla at all on
> LinuxPPC ?

No.  There's a bug that at least one person (Anthony Tong) is working
on finding, something with the shared libraries, I think.  SeaMonkey
has its own set of problems, in addition - I recommend playing with
classic mozilla instead.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|     CMU, CS class of 2002      |
|   Debian GNU/Linux Developer    __   Part-Time Systems Programmer  |
|         dan@debian.org         |  |        drow@cs.cmu.edu         |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
