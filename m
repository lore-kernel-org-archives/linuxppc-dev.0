Message-ID: <3EE14A54.7D33413C@opersys.com>
Date: Fri, 06 Jun 2003 22:13:40 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
MIME-Version: 1.0
To: Lokesh Kumar <lokesh.kumar@wrx-us.com>
Cc: brian.auld@adic.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: x86(host) --> ppc(tgt) cross-tool-chain
References: <3439AB3A99ECD5409F3A52ACF814744D158D23@norcom2.norcom.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lokesh Kumar wrote:
> Yes, it does work. I have a small web server running with glibc-2.2.3.
...
> > I built the toolchain on x86 host for PPC, and I used
> >
> > GCC-2.95.3
> > GLIBC-2.2.3
> > Binutils-2.11.92

It seems the success with a toolchain component version set depends on the
native tools you have on your workstation. Can you tell me what distro
you were using on your workstation when you built glibc 2.2.3 in the
above setup.

Thanks,

Karim

--
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
