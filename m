Message-ID: <37E50C29.CA2CE536@execpc.com>
Date: Sun, 19 Sep 1999 11:15:37 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: patches: MacOS-like Wallstreet sound in/out controls
References: <19990919105401.015601@smtp.calvacom.fr>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> A better solution would  be to make the appropriate infos available to
> userland (eventually via a private ioctl of the sound driver). Then, we
> could have an optional damon handling all this automatically that can be
> unplugged for people who like controlling everything manually. If no-one
> have time to write this, then you may include the patches anyway but
> wrapped in a compile option. (I'd like the volume button patch anyway).
> 
> On a similar way, I'm wondering what is the best way for the eth driver
> to tell userland about it's link status. I'd like to add to Paul's pmud a
> way to have scripts run when the link goes down and up. (basically, this
> would ifdown eth0 completely to remove it from the router, change my
> default route to the one I need for PPP, etc...)

since we aren't psychics, the daemon should have a configuration and script
place in /etc (/etc/pmu?).  the config would allow the user to control some
standard responses on how it acts internally. (like volume control, switching,
etc)  then the option to do additional things in scripts.  Given the potential
flexibility people may want, does this mean C is too static, and thus perl or
another more script-friendly language should be used?

If all goes well, we may eventually have a "apmd" for ppc.  any reason we
shouldn't try to use apmd as a framework?  have a so-called "apmd-compatibility"
mode where we can use the standard PC apmd as our frontend?  or does it not have
features like eth detect, so its not worth the bother?  (never had a pc laptop)

a few ideas from a peanut.

-- 
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
