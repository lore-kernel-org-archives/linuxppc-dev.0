Message-ID: <412F4618.8050705@intracom.gr>
Date: Fri, 27 Aug 2004 17:32:56 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Jaap-Jan Boor <jjboor@aimsys.nl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ushort fcc_fcce
References: <Pine.LNX.4.44.0408271130100.16734-100000@linpc003.aimsys.nl>
In-Reply-To: <Pine.LNX.4.44.0408271130100.16734-100000@linpc003.aimsys.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jaap-Jan Boor wrote:
> hi,
>
> Why is
> include/asm-ppc/immap_8260.h:   ushort  fcc_fcce;
>
> and not uint fcc_fcce, as e.g. the fcc event register
> in hdlc mode uses 32 bits.
>
> thanks,
>
> Jaap-Jan
>
>
>
>
>

Yep, this is correct.

FYI in the fec_8xx it is accessed as 32bits anyway.

Patch?

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
