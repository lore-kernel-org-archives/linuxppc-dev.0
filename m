Message-ID: <75DF04AC5ED4D511A9810090273CB4163F5DE5@rokonet-e.rokonet.co.il>
From: Eli Brin <elib@rokonet.co.il>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: 8xx SCC's as uart 
Date: Thu, 17 Jul 2003 13:28:26 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have noticed, in kernel 2.4.20, that SCC1 and SCC4 cannot be configured as
uarts.

Also, the configuration for RTS,CTS,DCD and DTR are missing.

Comparing 8xx_io/uart.c file to the 2.4.4 version of uart.c shows that all
the code to support the above has been removed, although both show driver
0.3.

Our target will use all SCC's as uarts with hardware handshake. So I will
need to put this back into uart.c and the config.in files.

Is there a reason for this feature (SCC1 and SCC4 as uarts are part of the
8xx ability) being removed ?

Thank you,
Eli Brin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
