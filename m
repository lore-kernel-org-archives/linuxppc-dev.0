Message-ID: <3E9EABCD.7090309@imc-berlin.de>
Date: Thu, 17 Apr 2003 15:27:41 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: cedric_aubert@yahoo.fr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: JFFS2 on the Host
References: <20030417131517.66513.qmail@web41813.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cedric,

> it's ok. But How can I make a full Binary Image of my
> flash partition (good size) on my host and after
> transfer it on the target at the right
> place with my loader (u-boot for example) ??

I am not sure if I understand your question. But if you want to know
how to create a flash image that you can burn onto your target then my
answer will be:

1. Create a root file system directory structure on your host.
    (e.g. use SELF from www.denx.de)
2. Run mkfs.jffs2 on this directory (make sure you use the correct
endianess) to create the flash image
3. Burn the resulting image onto your target using BDI2000 or U-Boot...

Hope this helps!

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
