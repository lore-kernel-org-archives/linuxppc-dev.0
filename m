From: supas100@astrophysik.uni-kiel.de (Derek Homeier)
Message-Id: <199910141546.RAA29436@juliet.astrophysik.uni-kiel.de>
Subject: Re: PMU daemon
To: linuxppc-dev@lists.linuxppc.org
Date: Thu, 14 Oct 1999 17:46:41 +0200 (MET DST)
Cc: paulus@linuxcare.com
In-Reply-To: <199910100459.XAA26749@lists.linuxppc.org> from "Linux PPC Developer Digest" at Oct 9, 99 11:59:22 pm
Reply-to: Derek Homeier <homeier@astrophysik.uni-kiel.de>
Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 9 Oct 1999 18:22:34 +1000, Paul Mackerras <paulus@linuxcare.com> wrote:
>
> I have extended my pmu daemon and Batmon to work on my new 1999 G3
> powerbook.  You can get it at ftp://ftp.linuxcare.com.au/pmud-0.2.tar.gz.
> It works on my old 3400 and I believe it should work on wallstreet
> powerbooks also.
> 
Thanks a lot, this works fine on my lombard. Is there any possibility to
let other battery monitors, such as wmapm/wmbattery benefit from this?

Another, perhaps a bit off-topic question: I managed to get my hd to spin down
again for some time with the current kernel (your 2.2.13), but Batmon indicates
only a minimal decrease in power consumption when it's spun down 
(the current goes down by something like 20-50 mA). Is this normal?

Cheers,
							Derek

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
