Date: Tue, 24 Aug 2004 01:31:54 -0700
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: How to port ppc-linux to new custom boards? (virtexII)
In-reply-to: <18802.1093328823@www32.gmx.net>
To: Patrick Huesmann <tricknology@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org, samlinuxppc@yahoo.com.cn
Message-id: <412AFCFA.2040006@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
References: <18802.1093328823@www32.gmx.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>this means that i also have to port u-boot
>
U-Boot supports the ML300 board, again, with MLD technology (i.e. an
automatic way to setup address maps and number of peripherals directly
out of the EDK project). Read the README for the ML300 board in the
u-boot documentation directory for more information.

- Peter


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
