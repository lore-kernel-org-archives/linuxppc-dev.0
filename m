Date: Wed, 7 Apr 1999 12:42:08 -0500 (CDT)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: a sun <asun@saul1.u.washington.edu>
cc: jskov@cygnus.co.uk, linuxppc-dev@lists.linuxppc.org, roy@centricsystems.ca,
        djweis@plconline.com, bh40@calva.net
Subject: Re: Resurrecting mkLinux
In-Reply-To: <199904071727.KAA07766@saul1.u.washington.edu>
Message-ID: <Pine.LNX.3.96.990407123435.3678G-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 7 Apr 1999, a sun wrote:

>    Also, the files that do not look like that are so because Jes (m68k
>    maintainer) didn't like '#ifdef __powerpc__' or CONFIG_APUS in
>    arch/m68k specific files... Which I agree with (kind of). With the
>    mach hierarchy, though, both arguments becomes moot and I'll fix up
>    the sources to my liking ;)
> 
> heh. luckily, most of the nubus stuff can be done by adding more
> gestalt values. hmm, i do have wonderful things like #ifdef
> __powerpc__ in the via_write/via_read code to do deal with memory
> barriers and such.

On a related point, I'm assuming that NuBus support will eventually be
expended to include the nubus PowerBooks and eventually, the 52/62/53/
63xx powermac/performa machines.  If not, then you really wouldn't have to
have the gestalt value.  But it's probably better to go ahead and put that
in, rather than having to mess with it later.  :-)

Also, a correction: the NuBus machines have a 53C94 and 53CF94, not 53C96
and 53CF96 as I reported previously.  I'm not sure why I thought they used
96es.  Oops.  :-)


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
