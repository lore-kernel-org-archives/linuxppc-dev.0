Date: Thu, 27 Jan 2000 21:39:02 +0100
From: Hartmut Koptein <koptein@inwestnet.de>
To: Nelson Abramson <pogtal@erols.com>
Cc: Kevin Puetz <puetzk@iastate.edu>, linuxppc-dev@lists.linuxppc.org,
        debian-powerpc@lists.debian.org
Subject: Re: Mozilla M13 Release Build Available
Message-ID: <20000127213902.H509@isis.de>
References: <E12DusK-0007We-00@puetz.penguinpowered.com> <3890AA00.36DE0DCD@erols.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3890AA00.36DE0DCD@erols.com>; from pogtal@erols.com on Thu, Jan 27, 2000 at 03:26:40PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> When I try and run "./mozilla", it starts, and then stops w/ the
> error: "./mozilla-bin: error in loading shared libraries: libelf.so.0: cannot open
> shared object file: No such file or directory "  Obviously this (or atleast seems
> like) a dependency error.  I have libelf installed (I rpmed a new copy jik), but
> the file definately does NOT exist on my hard drive.  What package should this
> file be part of..?  I checked libelf, it doesn't supply it...

For debian:  many .so.X sym-links comes from the -dev packages. Try

  /devel/libelfg0-dev_0.7.0-1.deb

Thnx,


    Hartmut

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
