Date: Thu, 13 May 1999 18:12:49 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: cvs kernel does not compile 
In-Reply-To: <199905131906.MAA17049@soda.CSUA.Berkeley.EDU>
Message-ID: <Pine.LNX.4.05.9905131812070.651-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 13 May 1999, Sriranga Veeraraghavan wrote:

> 
> > Well.  2.3.0 is 2.2.8.  2.3.1-pre2 (in CVS now) is not. :)
> 
> This may be a stupid question, but what is the best site to download
> the latest version of the kernel with the current PPC/PMac fixes?

Use CVS, but update your tree as:
cvs update -dP -rlinux_2_2

(http://cvs.on.openprojects.net)

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
