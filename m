Message-ID: <3890B567.D856104E@erols.com>
Date: Thu, 27 Jan 2000 16:15:19 -0500
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: ramp@oddjob.uchicago.edu
CC: Kevin Puetz <puetzk@iastate.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Mozilla M13 Release Build Available
References: <Pine.LNX.4.10.10001271441430.1687-100000@xpol.uchicago.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ramp@oddjob.uchicago.edu wrote:

> To get the required libelf.so.0 do the following
>
> # cd /usr/lib ; ls -l libelf.*
>     This should show libelf.a
>
> # ld -shared -o libelf.so.0 --whole-archive libelf.a
>     will create the dynamic library needed.
>
> I went beyond this and stuff started happening but seemed to hang.
> Maybe it was doing something?

Excellent suggestion.  After also installing the new libstdc++, it's up and running.
 Beyond excellent :)


--Nelson Abramson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
