Message-ID: <001001c0bd86$c54562a0$de0fa8c0@mystore>
From: "jerry" <jerry.nguyen@serialsystem.com.sg>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <20010404155419.8B369281DB@denx.denx.de>
Subject: how to get the physival address
Date: Thu, 5 Apr 2001 12:13:29 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I have a silly question but seem I can not figure out the answer myself. I
try write a driver, in which I define a array like"

file : dummy.o

unsigned  char buffer_array[4096];

....

bdp->cbd_bufaddr  =  __pa(buffer_array);


my problem is: I try to get the physical address of buffer array, but the
_pa did not return correct address.

I try to print out:  buffer_array = 0xC4056220
                        _pa(buffer_array) = 0x4056220

But my RAM only 16M = 0x100000

My question is: how to get the physical address of buffer_array.

Thank for any answer
Jerry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
