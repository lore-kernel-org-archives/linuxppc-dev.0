Message-ID: <3C60E7AF.5080007@pacbell.net>
Date: Wed, 06 Feb 2002 08:22:07 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: "Amit D. Chaudhary" <amitc@brocade.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Patch for latest ppc405_enet.c in source.mvista.com
References: <3C60B28E.7080803@brocade.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Amit D. Chaudhary wrote:

> Hi,
>
> Please find attached and pasted below patch for ppc405_enet.c for comments.
> The bk tree at source.mvista.com was based on 2.4.18-pre7 today when I
> picked it up.
>
> One change involves setting the flags for EMAC_IER, the manual does not
> mention any defaults hence using 0 for it did not seem appropriate.
>
> The second is a minor change of stats as the code uses transmit channel
> 0, the check for flag in ISR ought to be for the same.
>
> Regards
> Amit
>
>
> --- ppc405_enet.c    Tue Feb  5 18:52:43 2002
> +++ ppc405_enet-3.c    Tue Feb  5 19:38:23 2002


Amit,

Thanks for the patch.  It wont apply as-is (ppc405_enet-3.c does not
exist).  Since it is a smalll patch I will clean it up and submitted later.

-- armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
