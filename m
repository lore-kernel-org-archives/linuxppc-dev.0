Message-ID: <3C989DA4.E76C43A3@lvl7.com>
Date: Wed, 20 Mar 2002 09:33:08 -0500
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: Frank Haverkamp <f.haverkamp@web.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Debugging Multithreaded applications
References: <200203201427.g2KERAv17415@mailgate5.cinetic.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If your friends debug problems stem from the fact that when he does things like run his application in gdb, the breakpoints and backtraces don't seem to be correct, then I think his problem, is that he is running a pre v5.1 copy of gdb.  If I remember correctly, gdb 5.1 added features to better handle the debugging of multithreaded applications.  If the above behavior sounds familiar, I'd try getting the latest GDB.  Hope that helps!
Neil

Frank Haverkamp wrote:
>
> Hi,
>
> a friend of mine told me that he had problems debugging multithreaded
> applications on a powerpc Linux based platform. I think he is using
> glibc 2.1.3 and gcc-2.95.2 and libpthread-0.8.
>
> Does anybody has made experiences with that? Unfortunatly I have no
> more information about the system he is using. Are there any known
> problems with the gcc, glibc or libpthread concering debugging?
> Should he update? Which version should he than take?
>
> Which are the latest version of gcc, glibc and libpthread known to be
> working with powerpc Linux?
>
> Thanks,
>
> Frank
>
> --
> Frank Haverkamp
> f.haverkamp@web.de
> ________________________________________________________________
> Keine verlorenen Lotto-Quittungen, keine vergessenen Gewinne mehr!
> Beim WEB.DE Lottoservice: http://tippen2.web.de/?x=13
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
