Message-ID: <000b01c3bb61$0c4bec70$7ec7c7c7@dkhoo>
From: "Dennis Khoo" <dkhoo@atmxdsl.com>
To: "Jaap-Jan Boor" <jjboor@aimsys.nl>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <019501c3b9c5$b339a060$0400a8c0@eurostudio.local> <003f01c3b9fa$c66e0f10$7ec7c7c7@dkhoo> <1070622713.28153.5.camel@linpc003.aimsys.nl>
Subject: Re: problem using both mpc857dsl fec and scc1
Date: Fri, 5 Dec 2003 10:53:06 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Jaap-Jan,

> I would say to double check your parallel port I/O settings

Thanks

Actually, when I switched to ramdisk instead of NFS, then both SCC1 and FEC
work together.   Maybe some timimg issue in the fec.c code affected by
packets coming in initially?

Thanks again

Dennis Khoo
Software Engineer
Adapcom, INC


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
