In-Reply-To: <Pine.LNX.4.60.0407091333510.13457@localhost.localdomain>
References: <Pine.LNX.4.60.0407091333510.13457@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C223C568-D1D4-11D8-8835-000393C30512@freescale.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: should "860T FEC Ethernet" be an option for 8xx?
Date: Fri, 9 Jul 2004 13:21:12 -0500
To: "Robert P. J. Day" <rpjday@mindspring.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hm..  I think that's a bug in the Kconfig files.  I suspect it's
because the config options for the 8xx FEC and the 82xx FCC are the
same (CONFIG_FEC_ENET).  Is menuconfig picking up the help from the
other for this reason?  Anyway, this will be changing soon...ish.

On Jul 9, 2004, at 12:38, Robert P. J. Day wrote:

>
>   under "MPC8xx CPM Options", we have:
>
>      [ ] 860T FEC Ethernet
>
> whose help reads:
>
>   Enable Ethernet support via the Fast Ethernet Controller (FCC) on
>   the Motorola MPC8260.
>
>   but if it's specific to the 8260, it shouldn't even be available in
> the menu for 8xx, no?  either that, or the help is wrong.
>
> rday
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
