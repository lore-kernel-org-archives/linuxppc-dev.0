Subject: RE: Problem on unresolved symbol
Date: Thu, 18 Sep 2003 09:16:43 -0700
Message-ID: <7D17958F8536B640885BE12A446D548FCB2681@hq-ex-4.corp.brocade.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
From: "Ming Lei" <mlei@Brocade.COM>
To: <zjzhou@newrocktech.com>, <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


use EXPORT_SYMBOL for use with kernel module. You can look at website for kernel module programming info.

Ming

> -----Original Message-----
> From: John Zhou [mailto:zjzhou@newrocktech.com]
> Sent: Wednesday, September 17, 2003 9:00 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Problem on unresolved symbol
>
>
>
> Dear all,
>
> In my driver, I use the request_8xxirq() to connect my ISR
> function to IRQ. Building is OK, but, when I use insmod to
> load this module into kernel, it report " unresolved symbol
> request_8xxirq ". I found that in fcc_enet.c, it also use
> request_8xxirq() to do. Why does my action unsuccessed ?
>
> Could you help me?
>
> Thanks in advance!
> John
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
