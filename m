Message-Id: <200309040128.UAA25464@lists.linuxppc.org>
From: "Yuxiao Xi" <xiyuxiao@harbournetworks.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: DINK32 R13.1 on Sandpoint X2
Mime-Version: 1.0
Content-Type: text/plain
Date: Thu, 4 Sep 2003 09:37:40 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,Tom,
     From the mailing lists,I know that someone use DINK32's tftp
download function to download his image successfully on a Sandpoint X3
board.Is there any important differences between Sandpoint X3 and X2
board so that I can not use the DINK32's tftp function on X2 board?

======= 2003-09-03 11:04:00 ��=======

>On Tue, Sep 02, 2003 at 05:22:08PM +0800, Yuxiao Xi wrote:
>
>>     Now I'm working on a Motorola Sandpoint X2 board with ppc8240.
>> I use DINK32 r13.1 to boot my linux kernel image. From DINK32 r13.1
>> user manual,I know that DINK32 r13.1 supports ethernet card Realtek
>> 8139,but after these steps:
>
>What I would suggest is that instead of using the ethernet card
>support, you use the serial support still. DINK32 r13.0.0 and newer
>support 115200 baud, so loading a kernel via serial is now much less
>painful than it used to be.

= = = = = = = = = = = = = = = = = = = =

　　　　　　　　Yuxiao Xi
　　　　　　　　xiyuxiao@harbournetworks.com
　　　　　　　　　　2003-09-04

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
