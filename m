Message-ID: <3F5E0489.4070301@kegel.com>
Date: Tue, 09 Sep 2003 09:49:13 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Andr=E9_L=E4mmer?= <alaemmer@fh-konstanz.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling Kernel 2.6 for ppc32
References: <000001c376ed$eef95430$0f21258d@fhkonstanz.de>
In-Reply-To: <000001c376ed$eef95430$0f21258d@fhkonstanz.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


André Lämmer wrote:
> I tried to compile the kernel 2.6. test 4 for PowerPC. I used the cross
> compile tool chain ELDK V2.1 from Denx http://www.denx.de/. I am not
> able to make the kernel, because I get the following error.
>
> In file included from include/asm/system.h:8,
>                  from include/linux/list.h:8,
>                  from include/linux/signal.h:4,
>                  from arch/ppc/kernel/asm-offsets.c:12:
> include/linux/kernel.h:10: stdarg.h: Datei oder Verzeichnis nicht
> gefunden

There are quite a few mentions of this problem on google.
e.g.
http://www.cs.helsinki.fi/linux/linux-kernel/2003-11/0090.html

Does it build if you do
export LANG=C
unset LC_ALL
first?
- Dan

--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
