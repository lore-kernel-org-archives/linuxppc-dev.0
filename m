From: "Rick Hunnicutt" <rhunnicu@getntds.com>
To: "'Frank Haverkamp'" <f.haverkamp@web.de>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Debugging Multithreaded applications
Date: Wed, 20 Mar 2002 14:21:10 -0800
Message-ID: <000201c1d05d$8a745420$8df859c7@get.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200203201427.g2KERAv17415@mailgate5.cinetic.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


My configuration is:

  gcc 2.95.3
  glibc 1.2.8
  gdb 5.0
  libpthread-0.9

We've had good success debugging using gdb, setting breakpoints in different
threads, and such. This configuration came form MVista's 2.0 HHLinux for the
75X processor. gdb_server left a lot to be desired but the native gdb works
well for us.

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Frank
> Haverkamp
> Sent: Wednesday, March 20, 2002 6:27 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Debugging Multithreaded applications
>
>
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
>
> --
> Frank Haverkamp
> f.haverkamp@web.de
> ________________________________________________________________
> Keine verlorenen Lotto-Quittungen, keine vergessenen Gewinne mehr!
> Beim WEB.DE Lottoservice: http://tippen2.web.de/?x=13
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
