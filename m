From: Benjamin Herrenschmidt <bh40@calva.net>
To: Henry Worth <haworth@ncal.verio.com>, Troy Benjegerdes <hozer@drgw.net>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual G4 time issues..
Date: Mon, 18 Sep 2000 11:07:10 +0200
Message-Id: <20000918090710.14056@mailhost.mipsys.com>
In-Reply-To: <39C518A9.2BA320DA@ncal.verio.com>
References: <39C518A9.2BA320DA@ncal.verio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>So far the main problem I'm seeing with the SMP G4 and smp
>2.2.18pre4-ben1 is the system hangs up occasionally in xpmac
>rev 10, usually when closing an app or logging out. But I've seen
>nearly as many xpmac hangs in 2.2.17pre20-ben1 on a Pismo, but
>there I can switch VT's and recover. Whereas, on the SMP G4, VT
>switches won't work (USB -vs- ADB/PMU?). But, I can't telnet in
>either, so maybe it is a hard hang (though enough is alive that it
>pings -- not that that means much). Of course, if I have already
>telnet'ed in, it never hangs... Will hopefully have time
>to build and give XF86 4.0.x a try in a few days.
>
>Other than that, the other problems are the general non-SMP
>Rage128 nits of the 2.2.18 fb backport (character rendering
>artifacts and occasional raster flickers that probably
>indicate non-optimal mclk/sclk settings).
>
>Currently, I've got the CPU load up in the 1.4-1.6 range with
>no impact on GUI responsiveness and XMMS playing a CD digitally
>without dropping a beat.

I had reports of pthread-intensive applications having the threads
randomly "hang" when running on the SMP 2.2.x kernel. This happens on PPC
only (works fine with the same kernel on x86) and it's fine on UP.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
