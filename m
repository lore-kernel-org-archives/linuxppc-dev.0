Message-Id: <200001260720.IAA30349@denx.local.net>
To: brian.neidig@ni.com
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross-compiling standard utilities for 860
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 25 Jan 2000 20:45:48 CST."
             <86256872.000F3FAD.00@notesmta.natinst.com>
Date: Wed, 26 Jan 2000 08:20:24 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <86256872.000F3FAD.00@notesmta.natinst.com> you write:
>
> I am using an 860 based board, and am in need of several of the 'standard' Linux
> utilities.  (shells, module support, ls, etc.)  In the past, I've always gone to

When your kernel has the FPU emulation code included  you  should  be
able  to run the tools from a standard LinuxPPC distribution; this is
probably not optimal but the  easiest  way  to  get  startet  and  to
provide the full working environment for NFS based systems.

This way you only need to recompile/optimize those tools  you  really
put into your embedded system.

> the net and started looking around for an RPM containing the source code that I
> need and then take that and compile it for my platform.  However, lately, I've
> spent a lot of time not finding what I am looking for.  Is there a place someone
> can suggest that I can go to and get many of the standard utilities in source?

Any of the GNU archives, of course. See ftp://prep.ai.mit.edu/pub/gnu
for a starting point and a list of mirror sites.

> Sometimes, these utilities are in RPMs (if not all the time.)  Is there a place

RPM's are already a higl-level  issue;  usually  you  will  find  the
sources in (compressed) tarballs.

> that I can go to get a list of what utilities are in what RPMs?  (That is, how

RTFM for RPM! Use "rpm -qa" to get a listing of all installed  RPM's,
and "rpm -ql ql <rpm_name>" to get a list of files that come with RPM
<rpm_name>.

> would I know that the source to ls is in x.y-4.rpm?)   Distributions build them,
> so they have to exist somewhere!

Use
	rpm -qf `which ls`
to find out that "ls" belongs to the fileutils RPM (and thus compiles
from the sources in the fileutils tarball from your GNU mirror site).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
God may be subtle, but He isn't plain mean.         - Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
