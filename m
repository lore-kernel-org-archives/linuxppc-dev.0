Message-ID: <39C518A9.2BA320DA@ncal.verio.com>
Date: Sun, 17 Sep 2000 12:16:57 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@drgw.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: dual G4 time issues..
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Troy Benjegerdes <hozer@drgw.net>

>Benh and I are pushing Mac G4 SMP patches into the recently
>created linuxppc_2_5 tree. It currently seems to work reasonably well,
>except there is some work needing to be done on syncing the timebases on
>CPU's. I seem to have about a 14 second difference between the 2 CPU's on
>the machine I'm testing on now.
>
>(from ping -f)
>
>43505 packets transmitted, 43504 packets received, 0% packet loss
>round-trip min/avg/max = -144657.0/0.1/144657.3 ms

Troy,

Has your SMP G4 work in Ben's 2.2.18 source tree been folded
into any of the 2.4 source trees?

So far the main problem I'm seeing with the SMP G4 and smp
2.2.18pre4-ben1 is the system hangs up occasionally in xpmac
rev 10, usually when closing an app or logging out. But I've seen
nearly as many xpmac hangs in 2.2.17pre20-ben1 on a Pismo, but
there I can switch VT's and recover. Whereas, on the SMP G4, VT
switches won't work (USB -vs- ADB/PMU?). But, I can't telnet in
either, so maybe it is a hard hang (though enough is alive that it
pings -- not that that means much). Of course, if I have already
telnet'ed in, it never hangs... Will hopefully have time
to build and give XF86 4.0.x a try in a few days.

Other than that, the other problems are the general non-SMP
Rage128 nits of the 2.2.18 fb backport (character rendering
artifacts and occasional raster flickers that probably
indicate non-optimal mclk/sclk settings).

Currently, I've got the CPU load up in the 1.4-1.6 range with
no impact on GUI responsiveness and XMMS playing a CD digitally
without dropping a beat.

Thanks,
Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
