Date: Tue, 8 Feb 2000 17:09:29 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Bethe <dan_bethe@yahoo.com>
cc: Gabriel Ricard <g_ricard@yahoo.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: the state of the linuxppc-dev community
In-Reply-To: <20000208233505.29535.qmail@web1003.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10002081656590.30794-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Feb 2000, Dan Bethe wrote:

> 	The problem is that LinuxPPC.org has a development environment that is
> splintered, unstable, undocumented, obscure, nonintuitive, and basically
> impenetrable even to people who are fully dedicated to it such as Gabe and
> myself.  It is run almost exclusively on tribal knowledge that is only in the
> heads of the people who are writing the ppc-specific core of the OS.  There are
> no procedures and no interface.  And there is very little respect toward people
> like me and Gabe who have the time, dedication, and skills to clean it all up.

Well, yes.  A lot of it comes from everything else being splintered.
Userland is atleast somewhat unified.  Everybody (well, almost) uses at
least a common compiler/glibc.  Thats where the reference release came
in/out of.  We needed to hit glibc 2.1 and we needed everybody else to as
well.  Check out http://www.crashing.org/pressrel.txt (No, the 1.1 update
wasn't as widely published as 1.0, but it still hit lwn).  The kernel is a
whole 'nother ball of wax.

> 	First, obviously, we have to map out how everything currently is, before we
> could even suggest anything better.  But because 90% of the responses we get
> are either dead silence or asinine arguments like yours, we are slowly getting
> nowhere.  The remaining 10% are the responses of a mob cheering us on just for
> having pointed out the silly state of the maintenance of LinuxPPC.

By and large, there aren't many problems, directly related to userland.
compiler and libc bugs get pointed out on the proper lists (ie
gcc-*@gcc.gnu.org, or wherever the glibc bug program points you).  The
problem lies in that the two listed MAINTAINERS for Linux/PPC are either
busy and quite or just quite.  2.3.x still doesn't run on most machines
iirc, and 2.4 is close.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
