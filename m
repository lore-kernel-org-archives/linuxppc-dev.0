Message-ID: <3F7DB265.8050408@kegel.com>
Date: Fri, 03 Oct 2003 10:31:17 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Jacky Lam <jackylam@astri.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Queston about Walnut
References: <20031002121733.A2E32C59E4@atlas.denx.de> <001101c3894c$38833ab0$2803050a@JackyLam> <3F7D3238.2090400@bluewin.ch> <00df01c38992$6d179b40$2803050a@JackyLam> <3F7D9F72.9020700@kegel.com> <001b01c389cd$c3f30310$0202a8c0@homevl9biy3v7e>
In-Reply-To: <001b01c389cd$c3f30310$0202a8c0@homevl9biy3v7e>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jacky Lam wrote:
>     I upgrade my gcc to 3.3.1 on my host and start to compile my cross
> toolchain. However, while it is compiling gcc, it has strange error that I
> have never seen (seems gcc has made something that ld can't understand). So,
> I guess gcc 3.3.1 may not work very well with my old glibc (provided in
> RedHat 7.2). I don't know how to upgrade glibc safely and make it compatible
> to existing applications. That's why I would like to upgrade the whole
> Redhat.....and this is painful...

I see.  Well, you can always build and install a newer binutils;
that's not painful, and might get you past the problem.
(If you post the error message, we might be able to help.)

But I agree that doing a fresh install of e.g. Red Hat 9 is
nicer than keeping an old system alive by little patches
(unless you're going for an uptime record).

>># Download bk from http://www.bitkeeper.com
>>bk clone -r$1 bk://ppc.bkserver.net/linuxppc_2_4_devel
>
>         I use CVS to grab the linuxppc-2.4-devel module. Is it the same as
> that? Thanks.

Probably.  I dunno.
- Dan


--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
