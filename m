Message-ID: <20000328102933.10123.qmail@web119.yahoomail.com>
Date: Tue, 28 Mar 2000 02:29:33 -0800 (PST)
From: Michel "D?nzer" <mdaenzer@yahoo.com>
Reply-To: michdaen@iiic.ethz.ch
Subject: Re: Voodoo 3 bug on 2.3.99pre3
To: sabotage <kcz84@dial.pipex.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- sabotage <kcz84@dial.pipex.com> wrote:

>  I have a voodoo 3 2000 PCI card on my UMAX s900 SMP and i was trying to
> get the SMP and the Voodoo to work with linux I decided to start with the
> graphics card i got a 2.3.99pre3 kernel via ftp from kernel.org and
> compiled it with voodoo support but NO ati card support (since i dont have
> ati -- well i do but i dont use it and it failed to compile when i had ATI
> checked anyway) thus i it compiled booted but the whoole console display
was
> completely messed up sorta reversed with weird colors etc basically a
> complete mess.

Sounds like the usual endianness problems ...

What depth?


>  So i was just wondering if anyone had any ideas on getting it to work or
> am i wasting my time.....

AFAIK Kostas has the 3Dfx fbdev working.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
