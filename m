Message-ID: <3EFE94E4.90905@austin.rr.com>
Date: Sun, 29 Jun 2003 02:27:32 -0500
From: Jeff Hurst <jhurst2@austin.rr.com>
MIME-Version: 1.0
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx Microcode patch
References: <30C145E544071F4FB8B627789F7910BD328FF3@csy-exchange1.giat.intra>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ARIBAUD Albert wrote:
> Hi,
>
> Is there a synthetic resource on microcode patches across 8xx models?
 > What patches exist, which models need it, what they do.
 > I am especially interested in the MPC855T (IMMR says mask version 0502),
 > and reading the Motorola web page I see nothing about it needing microcode.
>
> Thanks in advance
> --
> Albert.

On the MPC860 page (the MPC855T is a family member) at Motorola web site:
MPC860MC04  MPC860 Microcode Patch for Relocating I2C/SPI Parameters
(03/06/2002)  contains a pdf.  It says 0502 is the last mask needing
the microcode.

--
Jeff Hurst


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
