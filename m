Message-ID: <3F5C15E8.70802@kegel.com>
Date: Sun, 07 Sep 2003 22:38:48 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: ??? <ksshin@essetel.com>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: interrupt handling in 7410+64260
References: <Pine.LNX.4.21.0308262014240.17370-100000@stimpy.bivio.net> <007301c36c53$079163c0$960aa8c0@ksshin> <3F4CE88B.2050307@mvista.com> <003301c375c4$866c2520$960aa8c0@ksshin>
In-Reply-To: <003301c375c4$866c2520$960aa8c0@ksshin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


??? wrote:
> according to your message, I try to find example source in
> my linux kernel(my Linux kernel is 2.4.18 from montavista)
> but I cannot find sources like cpci690.c, hxeb100.c and ev64260.c

Search http://marc.theaimsgroup.com/?l=linux-ppc for cpci690.c
You'll find a patch that refers to the arch/ppc/platforms/cpci690.c
in the linuxppc_2_4_devel tree.  This tree can be found at
http://www.penguinppc.org/dev/kernel.shtml

Maybe those files are in other trees, but hey, at least you know
where one example of them is now.
- Dan


--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
