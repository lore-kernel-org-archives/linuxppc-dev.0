Message-ID: <3CBC9FBC.CC205D36@xilinx.com>
Date: Tue, 16 Apr 2002 15:03:40 -0700
From: "Peter Ryser" <Peter.Ryser@xilinx.com>
MIME-Version: 1.0
To: James Campbell <jcampbell@omnigon.com>
Cc: Peter Ryser <Peter.Ryser@xilinx.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Virtex II Pro/405GP
References: <1018722334.3710.3.camel@skoll.omnigon.com>
		<3CBC7F1B.FF597841@xilinx.com> <1018990141.2034.12.camel@skoll.omnigon.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I was just curious if you had to use any esoteric patches on the (v2.5
> I'm assuming) kernel?

There are some patches. They are not esoteric and not publicly available at this
time :-(

>  Also, did you have to worry about using a full
> featured boot loader like ppcboot?

No, just use an external debugger to load the kernel into memory or use external
ROM or use the internal BRAM or System ACE (my favorite).
We are working on PPCBoot if you really need a full-blown boot loader.

- Peter


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
