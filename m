Message-ID: <38DC10F8.89ED2074@wanadoo.fr>
Date: Sat, 25 Mar 2000 02:06:00 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Request for Tulip 2.2.x testing...
References: <38DA7CF0.BC2E49D9@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


HI,

I did some testing with both versions. They both work for me in the same
way. The only difference I can see is one more line in /var/log/messages
when I start the patched module. The unpatched one gives me

kernel: tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
kernel: eth0: Digital DC21041 Tulip rev 33 at 0x400, 00:00:C5:47:6A:7C,
IRQ 25.
kernel: eth0: 21041 Media table, default media 0800 (Autosense).
kernel: eth0:  21041 media #0, 10baseT.
kernel: eth0:  21041 media #4, 10baseT-FD.

The patched one gives an additional line

kernel: eth0: 21143 10baseT link beat good.

Otherwise I see no difference in performance between the two (nor with
the de4x5 driver which I am normally using).

Do you need more information?

# cat /proc/version
Linux version 2.2.15-pre15 (root@chezmoi) (gcc version 2.95.2 19991024
(release/franzo)) #22 Sat Mar 25 00:46:00 CET 2000

--
Martin

Jeff Garzik wrote:
>
> Hi all!
>
> I was wondering if I could find anyone on here with a Tulip 21041 chip
> that could do some simple testing under 2.2.15-pre15?
>
> Questions for which answers are sought:
>
> Does tulip.c work with your 21041 chip unmodified?
> If yes, does the below patch break the tulip driver?
> If no, does the below patch get your 21041 working again?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
