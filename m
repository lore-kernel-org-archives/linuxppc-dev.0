Message-ID: <40B3C700.8030406@g-house.de>
Date: Wed, 26 May 2004 00:21:52 +0200
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Error: Unrecognized opcode: `dssall'
References: <40AE734D.1020609@g-house.de>
In-Reply-To: <40AE734D.1020609@g-house.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Christian Kujau schrieb:
| echo dssall | /usr/local/opt/crosstool_new/bin/powerpc-linux-as
| {standard input}: Assembler messages:
| {standard input}:1: Error: Unrecognized opcode: `dssall'

um, yes, obwviously this one was fixed in a later version of binutils.
i'm happy now :-)

Christian.
- --
BOFH excuse #46:

waste water tank overflowed onto computer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
