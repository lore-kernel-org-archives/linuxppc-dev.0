Message-ID: <3C16633A.1070906@gatekeeper.informatik.fh-dortmund.de>
Date: Tue, 11 Dec 2001 20:49:14 +0100
From: Ralf Weidemann <linuxppc@gatekeeper.informatik.fh-dortmund.de>
MIME-Version: 1.0
To: Derrik Pates <dpates@dsdk12.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.17pre4-ben0: cisco aironet driver x86 only / airport roaming support ?
References: <Pine.LNX.4.40.0112111027140.10784-100000@andromeda.dsdk12.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Derrik Pates wrote:

> On Tue, 11 Dec 2001, Ralf Weidemann wrote:
>
>
>>Should the cisco aironet driver work on ppc too or is it x86 only ?
>>I can load the modules, but the card seems not to work. Supports the
>>apple airport driver roaming with aironet 350 access points ? I can't
>>get both working and I wonder me if it should work.
>>
> You are running pcmcia-cs, and not just loading the Card Services driver
> modules outright, correct? Because that will not work - you have to run


Until now I tried only modprobe the airo_cs and yenta_socket
modules per hand. Is there maybe a pcmcia_cs package for ydl
2.1 or must I install it from the official pcmcia_cs source
tarball ? Hmm, in the SUPPORTED.CARDS file from the pcmcia_cs
tarball I can read the line "[airo_cs driver] [x86]", hope
this is not true anymore.

Ok, I will try the latest kernel with the pcmcia_cs tools and
will see what happens..

Thanks Derrik and Ben !

Ralf


> the pcmcia-cs agent daemon (cardmgr) to handle insertion and removal
> events, to configure device drivers, etc. If you are, make sure you follow
> Ben's advice about updating your kernel - he recently re-fixed a PCMCIA
> resource management bug in the kernel tree.
>
> Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
> dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
