Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3F298CED.8010701@windriver.com>
Date: Thu, 31 Jul 2003 22:41:01 +0100
From: Richard Danter <richard.danter@windriver.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 750/107 CHRP question
References: <3F2949D3.8020106@windriver.com> <20030731140700.A7553@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:
> [Oh my !#$!@.  I never thought I'd be replying to a Linux question
>  from WRS. I need to check for reports of natural disasters and
>  mass rioting. :)]

LOL!!

Yes, I work for WRS, but this is a little personal project just for the
hell of it. I just happen to be using a WRS board and vICE to do the
debugging.

>>
>>How do I map this correctly???
>
> In 2.4, you can use early_serial_setup() or io_block_map().  It is
> highly recommended to use early_serial_setup().  There are many
> examples of this (spruce, lopec, etc.)

Thanks, I'll take a look at that.

I'm sure this bit is easy, the tricky stuff will probably be when I
start playing with PCI...

Rich


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
