Message-ID: <3FCBCC0A.5060107@g-house.de>
Date: Tue, 02 Dec 2003 00:17:30 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: Remco Post <r.post@sara.nl>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6 PReP issues, still freezing
References: <3318B418-244D-11D8-A10A-000393911DE2@sara.nl>
In-Reply-To: <3318B418-244D-11D8-A10A-000393911DE2@sara.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Remco Post wrote:
> flops:~# ping 172.16.5.1
> PING 172.16.5.1 (172.16.5.1): 56 data bytes
>
> --- 172.16.5.1 ping statistics ---
> 2 packets transmitted, 0 packets received, 100% packet loss
> flops:~# eth0: link down
> eth0: timeout expired stopping DMA
> kernel BUG in de_set_media at drivers/net/tulip/de2104x.c:926!

so you really have a de2104x card. and your problems differ from mine,
as i never got any Oopses.

did you try Jeff Garzik's fixes for this driver?

http://marc.theaimsgroup.com/?l=linux-kernel&m=106950312306991&w=2

they were for some -test9-bk tree, but neither the -test10 nor the
-test11 ChangeLog says something about the fixes, so i think they are
still pending.

> CONFIG_PPC_CHRP=y
> CONFIG_PPC_PMAC=y
> CONFIG_PPC_PREP=y
> CONFIG_PPC_OF=y

how many archs do you want to boot at once? :-)


Thanks,
Christian.
--
BOFH excuse #233:

TCP/IP UDP alarm threshold is set too low.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
