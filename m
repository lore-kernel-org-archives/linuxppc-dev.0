Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3F56C5D3.9080202@einfochips.com>
Date: Thu, 04 Sep 2003 10:25:47 +0530
From: bhavin <bhavinp@einfochips.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problems with PM826 card
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,

    I am using a PM826 card with our own developed carrier extension
board. I have build the ppcboot image. I am booting the image from flash
and through serial communication SCC and I have configured the correct
serial channel number from our card's schematics. Now, the ppcboot works
but, when I try to write something in flash through ppcboot (either
'loadb' command or 'nm' command) the flash contents are not getting
changed. All other functionality of ppcboot works like erase, read, etc.
but all the functionality related to 'write to flash' is not working.
Can any one please suggest me what could be the possible reason??

Also, I have one separate program which, I downloaded from somewhere
which does some read/write operation to the PM826 card's flash. Through
that program the writing is working perfect.

Has it something to do with ppcboot configuration or the addressing mode?
Your help will be highly appreciated.


Thanks & Regards,
Bhavin Shah
Embedded Engineer
eInfochips Ltd.,
bhavinp@einfochips.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
