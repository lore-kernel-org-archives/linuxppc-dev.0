Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Sun, 04 Apr 2004 18:37:03 -0400
From: Jeff Tucker <jeff@jltnet.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re: Need help booting linux on IBM 405EP eval board
Message-ID: <72099343.1081103823@[192.168.2.18]>
In-Reply-To: <200404040435.i344Zm6P006731@ms.usish.com>
References: <200404040435.i344Zm6P006731@ms.usish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--On Sunday, April 04, 2004 12:35 PM +0800 Jack Liu <Jack_liu@usish.com>
wrote:

>
> yes, I guess your prolbem is like what Christian said before. Tye using
> console=ttyS0,9600 to append boot options.
>

Thanks for the suggestions, guys.

Actually, I had the statement above in my default command line option
compiled into the kernel. I also tried adding it to the "bootargs"
environment variable in U-Boot.

The exact same kernel boots with the IBM bootloader, including serial
console and network access. When I boot using U-Boot, I don't get a console
and there's no apparent network activity from the board.

Jeff

--
Jeff Tucker
jeff@jltnet.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
