From: kingseft@samsung.co.kr
Date: Thu, 8 Mar 2001 15:43:34 +0900
Message-Id: <H00002af04a94e43@MHS>
Subject: [Question] rc.sysinit .. auto start scripts??
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi, all developers...

 Thanks for your kind answers for my previous ramdisk problem..
 I made my own ramdisk and it workd fine... Really Thanks for helps..!!

 I have one question about /etc/rc.sysinit !!


 I think rc.sysinit runs automatically on system booting.. Is that right??
 but, when I booted my target, of course I got linux shell prompt.
 but /proc directory doesn't mount and didn't work ping, telnet, ifconfig...etc.

 After I tried /etc/rc.sysinit , every thing worked fine..

 Is it not possible to run etc.sysinit automatically on my linux booting??
 I don't want to type /etc/rc.sysinit on command shell prompt line when target boots..

 any comments will help me.. thanks.....


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
