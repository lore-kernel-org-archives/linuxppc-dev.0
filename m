Message-Id: <200404040435.i344Zm6P006731@ms.usish.com>
From: "Jack Liu" <Jack_liu@usish.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Re: Need help booting linux on IBM 405EP eval board
Mime-Version: 1.0
Content-Type: text/plain
Date: Sun, 4 Apr 2004 12:35:06 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


yes, I guess your prolbem is like what Christian said before. Tye using
console=ttyS0,9600 to append boot options.

======= 2004-04-02 23:40:00 Origianl message=======

>Am Friday 02 April 2004 20:33 schrieb Jeff Tucker:
>> I've re-built U-Boot in debug mode so I can see what is going on.
>> Here's what it spits out before the board locks up:
>[snip]
>> procfreq    = 266.666 MHz
>> plb_busfreq = 133.333 MHz
>> pci_busfreq = 33.333 MHz
>> ethaddr     = 00:04:AC:E3:24:A7
>> IP addr     = 192.168.0.91
>> baudrate    =   9600 bps
>> No initrd
>> ## Transferring control to Linux (at address 00000000) ...
>
>If you're connected via a serial console make sure to append the
>correct bootoptions to the kernel to get your output to /dev/ttySx.

= = = = = = = = = = = = = = = = = = = =

Best regards
Jack Liu
R&D Dept. USI(Shanghai) Inc.
Tel: +86-21-58966996x115
Fax: +86-21-58967931
Email: Jack_liu@usish.com
http://www.usi.com.tw

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
