Message-ID: <3890BE52.DBBD3904@erols.com>
Date: Thu, 27 Jan 2000 16:53:22 -0500
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: phandel@cise.ufl.edu
CC: ramp@oddjob.uchicago.edu, Kevin Puetz <puetzk@iastate.edu>,
        linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Mozilla M13 Release Build Available
References: <Pine.LNX.4.21.0001271619360.29611-100000@adsl-78-160-189.gnv.bellsouth.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


phandel@cise.ufl.edu wrote:

>
> I had to also do this:
>
> (5) adsl 4:15pm /usr/lib> ln -s libstdc++-libc6.1-1.1.so.2 libstdc++-libc6.1-2.so.3
>
> ...and now it works perfectly, although I am seeing a lot of this error:
>
> nsLayoutHistoryState::GetState, ERROR getting History state for the key
>

Hmm...maybe you should get the new libstdc++ instead of faking the link? :-)


HTH
--Nelson Abramson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
