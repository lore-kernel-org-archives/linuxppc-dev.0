From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>, <paulus@linuxcare.com.au>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.2.18pre17 again
Date: Tue, 31 Oct 2000 12:53:40 +0100
Message-Id: <19340925052524.13014@192.168.1.2>
In-Reply-To: <200010310649.HAA00860@piglet.grunz.lu>
References: <200010310649.HAA00860@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>- ICTC support in the sysctl interface:

Won't this require recalibrating the loops_per_jiffy for udelay() ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
