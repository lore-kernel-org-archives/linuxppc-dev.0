Message-Id: <200011091841.MAA32610@localhost.localdomain>
Date: Thu, 9 Nov 2000 12:41:27 -0600 (CST)
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
Subject: Re: Example miboot on new world rom problem
To: jcarr@mail.linuxppc.org
cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.21.0011091043510.1824-100000@jcarr.linuxppc.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  9 Nov, jcarr@mail.linuxppc.org wrote:
> The functionality of SetPRAMBoot(by that I mean the ability to do what
> startup disk does) needs to be added to yaboot not for the reasons I

'functionality'...  has anyone tested/written new code SPB for other
systems yet?

also must remember to add the bootvars/nvsetenv/ybin functionality for
the OF settings too.  Darwin seems to have its own System Disk program
that has XPRAM and OF covered.. except the pram part.  If that project
is open, might we want to try some code sharing?  Or does Apple own it?
Or might Apple be willing to share 9's Startup Disk info...

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
