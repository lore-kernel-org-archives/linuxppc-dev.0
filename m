Subject: RE: Linux Kernel hangs after execve('/bin/sh')
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 22 Jan 2003 15:35:38 -0500
Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B763497@mail1.mediatrix.com>
From: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
To: "Prakash kanthi" <pkanthi@yahoo.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Some important informations are missing to help you.
Which CPU model and revision are you using?
Which kernel version, taken from where?
Some newer CPU revs are incompatible with older kernels.

Regards,
--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

> -----Original Message-----
> From: Prakash kanthi [mailto:pkanthi@yahoo.com]
> Sent: 22 janvier, 2003 14:50
> To: dnevil@snmc.com
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Linux Kernel hangs after execve('/bin/sh')
>
>
>
> Hurray .......
>
> Daris, you suggestion seem to work. I Compiled my
> hello.c with -Bstatic (size was almost 1MB), added it
> to ramdisk and it works. So now the problem is
> narrowed down to, being not able to work with the
> shared libraries.
>
> One point is that, i DID NOT get any errors (atleast
> on the screen) while execve was loading shared
> libraries in the process of executing /bin/sh. But for
> sure, my problem is related to it.
>
> I really appreciate any suggestions related to this
> issue.
>
> Thanks,
> Prakash

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
