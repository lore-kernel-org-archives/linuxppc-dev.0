To: "Tolunay Orkun" <listmember@orkun.us>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IBM 440GX, Ocotea... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 23 Mar 2004 10:03:36 CST."
             <12605.216.110.51.8.1080057816.squirrel@www.orkun.us>
Date: Tue, 23 Mar 2004 17:44:36 +0100
Message-Id: <20040323164441.06AA0C1157@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Tolunay,

in message <12605.216.110.51.8.1080057816.squirrel@www.orkun.us> you wrote:
>
> > A more up-to-date implementation seems to be in the
> > "linuxppc-2.4" tree. Are there some open issues or known
> > problems? I realized that the L2 cache has been disabled
> > recently:
>
> Regarding penguinppc.org BitKeeper trees, I was told that
> linuxppc_2_4_devel tree is now dead and all commits are done against
> linuxppc-2.4. Perhaps maintainers can clarify that in more detail. My
> 405GP snapshot is coming from linuxppc-2.4.

Officially linuxppc-2.4 is the official tree ;-) But  then  it  seems
that  there  is  still a lot of difference between linuxppc_2_4_devel
and linuxppc-2.4, and I think you can find new features in both trees
that are not (yet?) present in the other tree.

> There is also another linuxppc_2_4_devel tree maintained by DENX. I don't

I guess Wolfgang Grandegger is aware of this. His other email address
is <wg@denx.de> :-)

But there are so many other trees. There is things like  the  ameslab
tree or the Linux-Tiny Tree or CELinux source tree or ...


> know the sync state between these two trees. It is my understanding that
> DENX tree has some fixes that might not be in the BK trees.

Our linuxppc_2_4_devel tree is in sync with the BK linuxppc_2_4_devel
tree. But there is lots of additional stuff in out  tree  that  never
made  it into the "official trees". So many of our contributions were
rejected or delayed or ignored that I finally gave up.

> IMHO, the community would be best served by single set of sources...

Indeed. But I think this is as likely as a world without war :-(

I would be perfectly happy if there was some plan or roadmap or  just
a  description of the current state which says which tree is in which
state, if it is maintained and by whom,  and  how  long  it  will  be
maintained, and when or why or by whom it might be declared as "dead"
(as  happened  with  the  linuxppc_2_4_devel  tree), or if anybody is
actually taking care of the known problems, and when, etc.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Inside every old person is a young person wondering what happened.
                              - Terry Pratchett, _Moving Pictures_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
