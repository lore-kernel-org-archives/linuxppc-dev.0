From: hollis@andrew.cmu.edu
Message-ID: <37F97754.37CA0ACC@andrew.cmu.edu>
Date: Mon, 04 Oct 1999 23:58:12 -0400
MIME-Version: 1.0
To: Mike Clubine <clubine@outeractive.com>
CC: linuxppc-user@lists.linuxppc.org,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: No Valid Monitor Settings for a PowerPC 8500/180
References: <37F9705D.FFA98080@outeractive.com>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mike Clubine wrote:
> 
> I am currently trying to install the latest version of linuxppc-1999 on
> my PowerPC 8500/180.  It has 1 Meg of video ram and it is not
> accelerated.  (Basically it's the stock onboard video.)  The install
> goes fine until the point in time that I am asked to configure my
> monitor setup.  This is where things get interesting.  I cannot find
> even one valid setting.

[snip trying a few monitors]

> Has anyone else run into this problem?  I can choose something generic
> and then skip out on on the x-test when installing, but then as soon as
> I boot up I get tons of error messages having to do with gpm being
> mysteriously murdered, even if I take it out of the appropriate rc.d
> directories.

Boot into runlevel 1 and try running Xautoconfig. (There's a page about
this at linuxppc.com/updates.) That should automatically generate a
working XF86Config file.

Does anyone (developers?) know why Xconfigurator chokes so horribly on
so many machines? Is it something different about Linux/PPC or a bug or
what? This "no valid monitor" thing is pretty common. Another one (what
I get) is a segfault immediately after detecting videocontroller  and
VRAM. Why doesn't it work?

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
