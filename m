Message-ID: <3E813CF5.9090001@paulidav.org>
Date: Tue, 25 Mar 2003 21:39:01 -0800
From: Vladimir Gurevich <vag@paulidav.org>
MIME-Version: 1.0
To: Kalpesh Jasapara <kjasapara@yahoo.com>
Cc: gdb@sources.redhat.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: GDB server and threaded application
References: <20030326035830.20755.qmail@web14601.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kalpesh!

Kalpesh Jasapara wrote:
> I am having a problem with remote gdb debugging
> using gdbserver to work with multi threads.
> The command "info threads" shows only one thread.

Here is a relevant excerpt from Wolfgang Denk's
posting from ppc-embedded:

> Dear Owen,
>
> in message <20020820144703.16442.qmail@web20107.mail.yahoo.com> you wrote:
>
>>
>> I`m trying to debug a multi-threaded application using
>> gdbserver on the remote/target side and I`m having
>> some problems, the output I got is depicted below:
>
>
> I'm not surprised. This is broken in most versions of GDB / gdbserver
> floating around.
>
>
>> I`m using gdbserver5.2.1 (I tried the one from HHL-2.0
>> Journeyman and didn`t worked too) compiled by myself
>> using Mvista HHL 2.0 tools and gdb 5.2.1 on my i386.
>> Am I doing something wrong or remote thread debugging
>> is not supported by gdb? I have read something about
>
>
> Let's say the support is incomplete :-)
>
>> problems with multi-thread application debugging but I
>> thought that it may be OK at this time...
>> Could someone explain to me what`s happening?
>
>
> Check out our ELDK  (see  http://www.denx.de/ELDK);  it  contains  an
> extended  /  bug  fixed  version  of  GDB  / gdbserver; remote target
> debugging of MT applications was one of the areas where we spend some
> work.
>
> If you're just looking for the patches: these can be found on our FTP
> server; the README including description of the test procedure is at
> ftp://ftp.denx.de/pub/ppc/patches/README-GDB-MT-Support
>

I hope this helps.

Cheers,
Vladimir


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
