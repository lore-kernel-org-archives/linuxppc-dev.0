Date: Wed, 18 Apr 2001 19:36:52 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Hideo Noda <Hideo_Noda@mutoh.co.jp>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC405GPWalnutPciBusMaster
Message-ID: <20010418193652.B19053@ecam.san.rr.com>
References: <3ADE42E8.6552066B@mutoh.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ADE42E8.6552066B@mutoh.co.jp>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 19, 2001 at 10:44:08AM +0900, Hideo Noda wrote:
> Has anyone tried PCI cards with BUS MASTER operations for Walnut
> PPC405GP?

I have tried and failed. I have other things to work on right now
so I have just delayed looking into it anymore until the 2.0 CDK
comes out. I think that should be by the end of the month.

I think there is a problem with the virt_to_phys matching the
PTM1/BAR1. In the preliminary 405gp docs that I have Fig 17-59
on page 17-62 give a good overview on how things need to be
setup on the chip, but I am not sure on what the values
need to be.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
