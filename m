To: tguilliams@sbs.com
Cc: Linux PPC Embedded List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ELDK build.sh seg faults 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "14 May 2003 15:18:42 PDT."
             <1052950722.22337.24.camel@corona>
Date: Thu, 15 May 2003 00:50:00 +0200
Message-Id: <20030514225005.67B7CC6092@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1052950722.22337.24.camel@corona> you wrote:
> Trying to build the ELDK from the CVS repository, I continually get a
> seg fault when build_package() is called in the build.sh script.  I'm
> running bash version -

Which version of (native_ RPM is running on your system?

> Suddenly, this is a problem for me.  It was building from CVS for me a
> couple months ago and I'm thinking some "upgrade" to my RH7.2 distro has
> caused something bad to happen but it doesn't seem to work for me on my
> HH8.0 guy either.  Investigating...

"HH8.0" probably means RedHat Linux 8.0 ?

Be careful; RH 8.0 comes with rpm-4.1 while the LDK build environment
has been tested only with rpm-4.0 (as used in RH-7.1, 7.2 and 7.3).

> Anyone have any immediate ideas what could be the problem??

I am aware of some build problems under RH 8.0 and 9, as well  as  on
more  recent versions of SuSE etc. However, for maximum compatibility
we build on a RH-7.1 system so there was no real  need  to  fix  this
yet.

Patches welcome.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Just go with the flow control, roll with the crunches, and, when  you
get a prompt, type like hell.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
