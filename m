From: "Andrew Dennison" <andrew.dennison@motec.com.au>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: JTAG debuggers for Motorola 8xx/82xx/85xx 
Date: Mon, 21 Jun 2004 10:21:13 +1000
Message-ID: <000d01c45725$a929c570$ee00a8c0@CAT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <000b01c45534$8542bba0$0301a8c0@chuck2>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Chambers wrote:
> Andrew,
>
> I went down this same path!  No, the 5200 JTAG is quite
> different from 8xx
> and a little different from 8xxx so no version of the Wiggler
> will work,
> although Macraigor says they are planning to support 5200 soon.
>
> When I was evaluating the 5200Lite I used the Motorola boot to load
> zImage.elf, and that let me play with linux.
>

Hi Mark,
Yeah - I used the Motorola boot loader to install u-boot to boot low on my
5200lite.

However I've almost finished our custom HW design so need proper tools to
bring up the new board. I'm doing both the hardware and software so I make
my own recommendations - after consulting with others so I don't re-invent
the wheel...

Hadn't realised there was a mix of BDM and JTAG on PPC processors - the
5200 is the first PPC I've played with.

Andrew


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
