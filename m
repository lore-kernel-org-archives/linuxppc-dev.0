Message-ID: <3AA72F37.FCF088B@serialsystem.com.sg>
Date: Thu, 08 Mar 2001 15:05:27 +0800
From: Jari Nguyen Trung Thanh <jari.nguyen@serialsystem.com.sg>
Reply-To: jari.nguyen@serialsystem.com.sg
MIME-Version: 1.0
To: kingseft@samsung.co.kr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Question] rc.sysinit .. auto start scripts??
References: <H00002af04a94e43@MHS>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You can look the file: /etc/inittab

This will have a line:
si::sysinit:/etc/rc.sysinit

/bin/init will look at /etc/inittab  and call this for you

Hope this help,
Jari

kingseft@samsung.co.kr wrote:

>  Hi, all developers...
>
>  Thanks for your kind answers for my previous ramdisk problem..
>  I made my own ramdisk and it workd fine... Really Thanks for helps..!!
>
>  I have one question about /etc/rc.sysinit !!
>
>  I think rc.sysinit runs automatically on system booting.. Is that right??
>  but, when I booted my target, of course I got linux shell prompt.
>  but /proc directory doesn't mount and didn't work ping, telnet, ifconfig...etc.
>
>  After I tried /etc/rc.sysinit , every thing worked fine..
>
>  Is it not possible to run etc.sysinit automatically on my linux booting??
>  I don't want to type /etc/rc.sysinit on command shell prompt line when target boots..
>
>  any comments will help me.. thanks.....
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
