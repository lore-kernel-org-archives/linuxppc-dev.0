Date: Thu, 29 Jul 2004 14:46:53 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: m madhuker <mythri_madhuker@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problem with compiling ppcboot
Message-ID: <20040729124652.GL21917@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <20040729121949.23526.qmail@web13603.mail.yahoo.com>
Mime-Version: 1.0
In-Reply-To: <20040729121949.23526.qmail@web13603.mail.yahoo.com>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> ppcstring.o ppcstring.S
> ppc-elf-gcc: installation problem, cannot exec `cpp0':
> No such file or directoryas: unrecognized option `-mppc'

Check your installation and/or path. I don't think this is related to
ppcboot, but rather to your system you compile the sources on.

btw, change to u-boot if you only start porting, you'll avoid problems
(inherited code, been there, done that): http://u-boot.sourceforge.net/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
