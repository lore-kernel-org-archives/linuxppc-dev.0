Message-ID: <39D214AA.F279478@mvista.com>
Date: Wed, 27 Sep 2000 08:39:22 -0700
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: Dag Nygren <dag@newtech.fi>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Porting problems
References: <20000927104034.1293.qmail@dag.newtech.fi>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dag,
Looking at your panic it appears you are
accessing a memory location that is not valid.
Have you set up your board memory map
to include the addresses referenced? Try looking
at this first.
Cal

Dag Nygren wrote:

> Sorry, forgot something:
>
> The kernel is compiled from the generic linux-2.4.0-test6
> sources. Have tested with generic 2.2.14  and linux-2.4.0-test5
> as well and is doesn't seem to matter.
>
> --
> Dag Nygren                               email: dag@newtech.fi
> Oy NewTech Ab                            phone: +358 9 8024910
> Trasktorpet 3                              fax: +358 9 8024916
> 02360 ESBO                                 GSM: 0400-426312
> FINLAND
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Customer Support Engineer    490 Potrero Avenue
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         e-mail cal_erickson@mvista.com
Pager 877-566-2012           support 1-800-759-8888 pin 202-7489
web http://www.mvista.com    support e-mail: support@mvista.com
eCode: http://cal@work.com.ecode.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
