Message-Id: <200008312130.XAA00901@piglet.grunz.lu>
Date: Thu, 31 Aug 2000 23:30:46 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2.4 problems
To: dan@netx4.com
cc: daenzerm@student.ethz.ch, jpgarcia@execpc.com, paubert@iram.es,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39AEB110.346A9DC9@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  31 Aug, this message from Dan Malek echoed through cyberspace:
>
> Michel Dänzer wrote:
>
>> Haven't seen that.
>
> My 7200 won't even boot.....

And my G3-graded 7600 will only boot one out of 10-20 tries. The other
times, it dies at random places somewhere in init/main.c. When it does
boot up, it dies awfully while processing the rc scripts, with the oops
not showing any apparent problem. That crash is evil, since all
partitions except root will appear to be clean when in fact they are
not.

Which means major havoc will start to appear on my disks if I don't
force an immediate clean fsck....

I'd help debug the 2.4 kernels further, if I could get past these two
problems.... I've just now re-rsync'ed Paul's tree, lets see if there's
any difference....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
