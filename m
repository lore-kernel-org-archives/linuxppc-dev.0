Message-ID: <3974C0DD.7097988A@execpc.com>
Date: Tue, 18 Jul 2000 15:41:01 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: switching consoles
References: <Pine.SOL.3.95.1000718222308.3933C-100000@juliet>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Derek Homeier wrote:
> On Fri, 14 Jul 2000, Joseph Garcia wrote:
> > I suppose you could try setting it back and forth and getting a hexdump of nvram
> > and then diff them to find the common thread.  then write an app that does it
> > for you.
>
> You mean, writing an app that can set it in Linux? Well, would be even
> slicker, actually I was only thinking about some OF command like
> 'setenv keyxxx yyy' to not have to fully boot into MacOS every time the
> bootvars are reset. But a linux utility would really be quite useful,
> unfortunately I've never played with OF settings from within Linux.
> I'll have a look at your setpramboot docs, though.

After writing this, i thought.. hmm.  isn't that a lot more a 'trackpad' tap
like thing, rather than a OF thing?  If it is stored in nvram, its probably just
read by a MacOS extention, which then sets the hardware.  so its probably not as
straight forward as I thought/made it out to seem.  My bad.

anyone know how this is actually done?  I think a Linux app would be the
ultimate solution.  trackpad is a required tool for pb users IMO, and this could
become another of those tools.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
