Message-ID: <399614D3.766593CC@denise.shiny.it>
Date: Sat, 12 Aug 2000 23:24:03 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Michel Dänzer <daenzerm@student.ethz.ch>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4, speed and keyboard problems
References: <39835F2B.36C12CC9@denise.shiny.it> <3984265B.631EB6C4@student.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
>
> Giuliano Pochini wrote:
> >
> > Hi! I finally installed XF4. It seems faster for most of operations (windows
> > movement is smothes, xscreensever runs fater, etc), but all visualization
> > plugins for Alsaplayer and xmms are 30% slower according to CPU usage
> > (print_a_bitmap_on_the_screen() is slower ??).
>
> CPU usage of the plugins or the server? You have to sum up both to get the
> actual CPU usage with both versions of X.
>
> Can you please provide numbers?


I made these test with x11perf:


test             4.0       3.3.6-XPmac_aty128
---------------------------------------------
putimage100      669           788
putimagexy100    224            83
shmput100       1075          1300
shmputxy100        6             6   (bleah)
putimage500       23.9          28.1
shmput500         43            51.6


I don't know how much this test is valid, since I run the old
XPMac server over a 4.0 environment (libs, fonts, tools, etc.),
anyway the speed loss in put-image calls is around 20%.

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
