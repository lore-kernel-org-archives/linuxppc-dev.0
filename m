Message-ID: <3CC42CB6.20007@allot.com>
Date: Mon, 22 Apr 2002 18:31:02 +0300
From: Felix Radensky <felix@allot.com>
MIME-Version: 1.0
To: Felix Radensky <felix@allot.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross compiling gdb-5.1.1 for ppc405
References: <3CC40B91.90601@allot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've found the problem: I was running configure like this:
   configure --prefix=/usr --host=i386-unknown-linux
--target=powerpc-unknown-linux

It should really be:
   configure --prefix=/usr powerpc-unknown-linux

Felix.

Felix Radensky wrote:

>
> Hi,
>
> I've managed to cross-compile gdb-5.1.1 for 405GP using
> Monta Vista HHL 2.0 toolchain.  Gdb runs, I can load the executable
> and set breakpoints. However, when i try to run the  program from gdb,
> I get the following message:
>
> Starting program: /tmp/hello
> Don't know how to run.  Try "help target".
>
> The same program runs fine  in gdb-5.0 from Monta Vista
> HHL 2.0.
>
> Any ideas ?
>
> Thanks a lot.
>
> Felix.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
