Message-Id: <200101221522.f0MFMIm24758@denx.local.net>
To: Daniel Furse <daniel.furse@iptest.com>
cc: "Linux Embedded List (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Neighbour table overflow 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 Jan 2001 14:38:44 GMT."
             <0D9416AE7F95D411A8710008C7332F3F054382@GUILDFORD4_NT>
Date: Mon, 22 Jan 2001 16:22:18 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <0D9416AE7F95D411A8710008C7332F3F054382@GUILDFORD4_NT> you wrote:
>
> Is there anything else that I should change?

No.

> => bootp;setenv bootargs init=/bin/bash root=/dev/nfs rw nfsroot=$(serverip):$(rootpath) ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname)::off;bootm
> BOOTP broadcast 1
> ARP broadcast 1
> TFTP from server 159.75.55.94; our IP address is 159.75.55.219
> Filename '/tftpboot/pImage-TQM860L'.
> Load address: 0x100000
> Loading:
> #######################################################################
> ####

You can be sure the hardware's working.

> Boot arguments: init=/bin/bash root=/dev/nfs rw nfsroot=159.75.55.94:
> ip=159.75.
> 55.219:159.75.55.94::255.255.255.0:tqmboard::off

I don't see any root path here.

Please  run  the  "bootp"  command  manually,  and  check  thet   the
"rootpath"  environment  variable  is  set after it. If it's missing,
check your BOOTP server configuration.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Visit us at Embedded Systems: Feb 14-16 2001, Nuremberg, Halle 12/K01
(with TQ Components); our presentation "Starke Zwerge: Embedded Linux
auf PowerPC-Systemen" on Thursday, Feb 15 2001, 13:30 Forum Halle 11.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
