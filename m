From: g.ramakrishna@exgate.tek.com
Message-ID: <301A812E6528D511A8F70008C71E578601D3402A@AP-BANG-M02>
To: jan.damborsky@devcom.cz
Cc: linuxppc-dev@lists.linuxppc.org
Subject: RE: X windows for Linux PPC embedded
Date: Wed, 26 Feb 2003 21:27:23 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>I would like to ask, if there is some project
>>>for porting X windows system to Embedded
>>>PPC Linux. I use board with MPC823E with
>>>VGA TFT display+touch screen, 32MB RWM,
>>>4MB FLASH, Ethernet, serial RS232,....
>>>I would like to use it as remote graphic terminal
>>>communicating via Ethernet by means of X protocol.
>>>Does somebody know how to make it work ?
>>>
>>>
>>
>>
>>There is nothing much to port.  Few months back I had cross-compiled TinyX
>>successfully for a MPC860 board on x86 platform.
>>Except the proprietary touch screen interface(we added this ourself),
>>everything else worked fine on the target framebuffer device.  But I
haven't
>>tried the complete X.
>>I hope this information is useful for you.
>>
>> regards,
>>Ramakrishna, G
>>
>>
>>
>Thank you for your information. We have 32M of DRAM, 16M of FLASH on board.
>Do you think it is sufficient for make tinyX working?
>
>                HANYS

It is more than enough.  We had 16M of DRAM and 16M of FLASH on the target.

Regards,
Ramakrishna, G

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
