Message-ID: <3BBADB78.7ADE82CA@staubli.com>
Date: Wed, 03 Oct 2001 11:33:45 +0200
From: Pierre AUBERT <p.aubert@staubli.com>
MIME-Version: 1.0
To: Kapil Konde <kapilkk@yahoo.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Bad Magic Number
References: <GDEHIPAFEMJDKNFDCIEBIEGECCAA.kapilkk@yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kapil Konde wrote:

> Hi all,
>         I am trying to boot linux on my custom mpc8xx card. I have ppcboot loaded
> and I am loading linux kernel image using tftp. When I say bootm it gives me
> error "Bad Magic Number".
> Can anybody please explain the error and suggest any solution for it.
>
> Thanks in advance,
> Kapilk.

If you want to use the bootm command, you need to build your linux kernel with the
mkimage tool (this tool is included in the ppcboot package).

Regards

--
------------------------------------------------------------------------------
Pierre Aubert                   |   Phone:  +33 4 50 65 62 88
                                |   Fax:    +33 4 50 65 62 08
STÄUBLI Faverges                |
Place Robert STÄUBLI            |   Mailto:p.aubert@staubli.com
74210 Faverges FRANCE           |   http://www.staubli.com
------------------------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
