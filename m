Message-ID: <3E2F3B79.2070408@paulidav.org>
Date: Wed, 22 Jan 2003 16:46:49 -0800
From: Vladimir Gurevich <vag@paulidav.org>
MIME-Version: 1.0
To: Jason Park <jason@amadeus.kist.re.kr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem with BDI2000 flash programming
References: <003201c2c275$45a441b0$5e207aa1@fish>
In-Reply-To: <003201c2c275$45a441b0$5e207aa1@fish>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Jason,

You are correct that your BDI2000 downloads the config file
successfully. Otherwise, it should print a message like

          *** CONFIG: cannot open ep8260.cfg.init

all the time once you telnet to BDI.

I'd suggest you check permissions on /tftpboot/ppcboot.bin
It should be readable by all.

Happy hacking,
Vladimir Gurevich


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
