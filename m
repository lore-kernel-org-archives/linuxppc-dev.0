Date: Fri, 27 Aug 2004 19:14:09 +0200
Subject: Re: ushort fcc_fcce
From: Jaap Jan Boor <jjboor@aimsys.nl>
To: Dan Malek <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <BD553881.251%jjboor@aimsys.nl>
In-Reply-To: <CE15CB43-F838-11D8-BF10-003065F9B7DC@embeddededge.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 27-08-2004 16:53, "Dan Malek" <dan@embeddededge.com> wrote:

>
> On Aug 27, 2004, at 5:31 AM, Jaap-Jan Boor wrote:
>
>> Why is
>> include/asm-ppc/immap_8260.h:   ushort  fcc_fcce;
>
> Because in the original documentation I had under NDA
> many years ago when this was written didn't describe
> ATM nor HDLC.  It listed this as a 16-bit field for Ethernet.
>
> I've made a note to change it.

ok, thanks

Jaap-Jan

>
> Thanks.
>
> -- Dan
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
