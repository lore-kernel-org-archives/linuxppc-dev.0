Message-Id: <200001281022.LAA30623@denx.local.net>
To: "Linux PPC Embedded" <linuxppc-embedded@lists.linuxppc.org>,
        "Linux PPC Dev" <linuxppc-dev@lists.linuxppc.org>,
        greyham@research.canon.com.au (Graham Stoney)
Subject: Re: [ANNOUNCE] MPC8xx example device drivers
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 14 Jan 2000 00:34:01 +0100."
Date: Fri, 28 Jan 2000 11:22:06 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


While trying to help some  customers  getting  started  with  writing
device  drivers for MPC8xx systems we developed some example drivers.
The drivers are quite simple and more for educational than  practical
purposes:

trv:	["TRiVial" driver] This driver demonstrates the use of the
        basic kernel functions and system calls for a memory "buffer"
        device. It is generic and runs on PPC and x86 as well.

tid:	["Trivial Interrupt Driver"] The purpose of this driver is to
        demonstrate real hardware accesses, CPM interrupt processing,
        and passing of module parameters. It  uses  one  of  the  CPM
        timers to create interrupts.

tqm_led: ["TQM8xx LED" driver] This driver  is  specific  to  the  TQ
        Components  STK8xx  starter  kit:  it  provides a very simple
        example how to control external devices (here the LEDs on the
        starter kit board) using the CPM parallel ports.

The sources for these drivers can be found on:

	ftp://ftp.denx.de/pub/LinuxPPC/usr/src/drivers.tar.gz


I'm especially grateful to Jean-Jacques Germond, Frédéric Soulier and
Christian Batt for allowing to make their work Open Source.


ALL type of feedback is welcome,  especially  all  contributions  for
improvement.


Wolfgang

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
No, I'm not going to explain it. If you  can't  figure  it  out,  you
didn't want to know anyway... :-)
                   - Larry Wall in <1991Aug7.180856.2854@netlabs.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
