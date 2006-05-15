Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa4.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id 98DED679E9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 May 2006 05:46:16 +1000 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: "Yang, Steve" <steve.yang@windriver.com>
Subject: Re: Routing problem
Date: Mon, 15 May 2006 21:39:18 +0200
References: <D9055C0A0A86BD4E89AD96A89EA767DB09C061@ALA-MAIL03.corp.ad.wrs.com>
In-Reply-To: <D9055C0A0A86BD4E89AD96A89EA767DB09C061@ALA-MAIL03.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605152139.18945.antonio.dibacco@aruba.it>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

No effect!
I don't understand what is missing in my system.

Thank you for your attention.

Bye,
Antonio.

On Monday 15 May 2006 18:08, Yang, Steve wrote:
> Antonio,
>
> Try this:
>
>   sysctl net.ipv4.ip_forward=1
>
> Regards,
> Steve Yang
> 510-749-4535 Alameda
> AIM: steveyang4535
>
> -----Original Message-----
> From: linuxppc-embedded-bounces+syang=windriver.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+syang=windriver.com@ozlabs.org] On
> Behalf Of Antonio Di Bacco
> Sent: Friday, May 12, 2006 1:53 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Routing problem
>
> Hi all,
>
> I have a board with an MPC880 using the tow FECs as two ethernet
> interfaces. I tried to enable the ip forwarding with no success. I have
> issued  "echo 1
>
> > /proc/sys/net/ipv4/ip_forward", is it sufficient to make Linux work as
> >
> > a
>
> router?
>
> Bye,
> Antonio.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
