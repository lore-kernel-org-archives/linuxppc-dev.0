Message-Id: <v03110700b52cddca8e45@[129.100.29.243]>
In-Reply-To: <00042613142600.25418@khendricks_mac>
References: <v03110700b52cb98e15b9@[129.100.29.243]>
 <v03110700b52c8481fb7e@[209.183.131.177]>
 <v03110700b52cb98e15b9@[129.100.29.243]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 26 Apr 2000 13:57:26 -0400
To: Giovanna Ambrosini <ambrosini@lightning.ch>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: patch: POSIX.1b signals for ppc
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Giovanna,

>I will try to exercise the SA_SIGINFO info in some signal handlers to make
>sure
>things are working okay.

Seems to be working fine!  The additional debug info is a big help.

That only leaves the ucontext stuff to test yet which is what I really need
since it allows stack overflow checking to be done on an exception basis
(i.e when it occurs) and not before every and every access which should
speed up the jdk interpreter significantly.

Thanks,

Kevin

--
Kevin B. Hendricks, Associate Professor of Operations and Information
Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
