Date: Tue, 2 Apr 2002 23:12:51 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc_2_4_alt started
Message-ID: <20020402231251.I6003@altus.drgw.net>
References: <0203310558.AA21170@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0203310558.AA21170@ivan.Harhan.ORG>; from msokolov@ivan.Harhan.ORG on Sat, Mar 30, 2002 at 09:58:33PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Mar 30, 2002 at 09:58:33PM -0800, Michael Sokolov wrote:
>
> Linux/PPC developers and users,
>
> Having had no success in getting my work accepted into linuxppc_2_4_devel, I
> have decided to start my own alternative tree which I have called
> linuxppc_2_4_alt. The BK URL for anonymous access (should work, but I couldn't
> really test access from outside) is:
>
> bk://helium.Harhan.ORG:5000
>
> This tree has linuxppc_2_4_devel as its BK parent. I have had this BK tree for
> a while but I've just now made it publicly accessible. (The patches in my CVS
> were generated from this tree with bk export -tpatch between the last cset
> pulled from 2_4_devel and the very top cset.)
>
> I have set it up to post to linuxppc-commit@source.mvista.com on incoming just
> like the trees at BitMover. This way y'all will now what I'm doing in there and
> see if you like it. If enough people like it maybe we'll take over. Anyone who
> likes this tree, wants to do development in it, and wants read/write access
> should contact me.

Oh yeah.. you should read and understand the documentation for 'bk level',
and set the level of your repository so nobody can accidentally push the
_alt tree to _devel.

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
