Message-ID: <3F5DFFBA.3000309@kegel.com>
Date: Tue, 09 Sep 2003 09:28:42 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: t.vanremortel@ha.be
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross compilation question
References: <1063093493.12979.4.camel@toni>
In-Reply-To: <1063093493.12979.4.camel@toni>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Toni Van Remortel wrote:
> Hi all,
>
> I've installed ELDK as compiler-set, and it is successfully used to
> compile linuxppc_2_4_devel, rtai and FLTK for my EP405 board.
>
> Now I have a FLTK-based program which I like to cross-compile, but I get
> stuck to one error I cannot solve right now:
>
> ppc_4xx-g++ -static -g test.cxx -I/ppc/fltk-1.1.4rc2 -o test
> -L/opt/eldk/ppc_4xx/lib -L/opt/eldk/ppc_4xx/usr/lib
> -L/ppc/fltk-1.1.4rc2/lib -L/opt/PPC_X/usr/X11R6/lib -L/opt/PPC_X/usr/lib
> -lfltk -lXext -lX11
> /opt/eldk/usr/ppc-linux/bin/ld: cannot find -lstdc++
> collect2: ld returned 1 exit status
>
> As far as I know, is libstdc++.so in /opt/eldk/ppc_4xx/usr/lib, which is
> added as -L.

Do you have a libstdc++.a?  You'd need that to satisfy the -static.
- Dan


--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
