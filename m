Message-ID: <3E3BA83F.6060002@bluewin.ch>
Date: Sat, 01 Feb 2003 11:58:07 +0100
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: OHMURA Yutaka <ohmura@co-nss.co.jp>
Cc: acurtis@onz.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to use EP8260 MTD device?
References: <NCBBIINEHIPFGJPLBEIFOEKEEBAA.acurtis@onz.com> <20030201153711K-Z0vd@co-nss.co.jp>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 02/01/2003 07:37 AM OHMURA Yutaka wrote:
>> > By the way, TSL uses DEC register for timer, is this same in pure
>> > PPC-Linux?
>> > I could't find pure PPC-Linux 2.4.7 source code...
>>
>> It is there, you have to learn how to use bitkeeper.
>>
>
> Hmmm,
>
> I searched under http://www.kernel.org/pub/linux/kernel/ports/ppc/, but the
> oldest patch for PPC was made for 2.4.10 kernel. Did I search wrong place?

Check http://www.penguinppc.org/dev/kernel.shtml. The patches you
mentioned are against the linuxppc_2_4 tree but for a lot of embedded
boards the linuxppc_2_4_devel tree is the better choice.

Good luck,

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
