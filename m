From: unit@panix.com
Date: Thu, 2 Dec 1999 22:14:44 -0500 (EST)
To: jingai <jingai@earthlink.net>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: ppp not working w/ kernel 2.3.29
In-Reply-To: <199912020507.VAA19020@scaup.prod.itd.earthlink.net>
Message-ID: <Pine.GSU.4.05.9912022158330.22111-100000@panix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 2 Dec 1999, jingai wrote:

> Well, I've finally got a 2.3 kernel up and running, and thanks to Ira, my USB
> mouse now works as well.  But, I've got one last problem:  ppp isn't working. 
> pppd claims that I don't have kernel support for PPP, but it is definitely compiled
> in (or, at least, it is enabled in the .config file).
> 
> Has anyone else experienced this?  Do I need to update pppd perhaps?  Or is
> there just a specific combination of (possibly unrelated) options that need to be
> enabled for PPP to work in 2.3.29 (Paul's unstable tree)?

jingai ..

i had the exact same problem with 2.3.22 (with ajoshi's patche) a while
back .. what the problem is i can't say .. however i am (as of this past
20 minutes) running pppd on pauls 2.3.29 .. prehaps yr right regarding ppp
as i had updated ppp just recently (see the rpm in ftp.linuxppc.org/contrib)

hope this is of some help

cal-s


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
