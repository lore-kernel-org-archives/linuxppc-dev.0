Date: Wed, 3 Sep 2003 11:04:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Yuxiao Xi <xiyuxiao@harbournetworks.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: DINK32 R13.1 on Sandpoint X2
Message-ID: <20030903180400.GB11224@ip68-0-152-218.tc.ph.cox.net>
References: <200309020913.EAA17470@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309020913.EAA17470@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 02, 2003 at 05:22:08PM +0800, Yuxiao Xi wrote:

>
> Hi,all,
>     Now I'm working on a Motorola Sandpoint X2 board with ppc8240.
> I use DINK32 r13.1 to boot my linux kernel image.
>     From DINK32 r13.1 user manual,I know that DINK32 r13.1 supports
> ethernet card Realtek 8139,but after these steps:

What I would suggest is that instead of using the ethernet card support,
you use the serial support still.  DINK32 r13.0.0 and newer support
115200 baud, so loading a kernel via serial is now much less painful
than it used to be.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
