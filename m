Message-ID: <3C70F4F9.7010503@elsoft.ch>
Date: Mon, 18 Feb 2002 13:35:05 +0100
From: "David =?ISO-8859-15?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Armin <akuster@pacbell.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Several patches against linuxppc_devel-2.4.18-rc1
References: <3C6E5603.5010801@elsoft.ch> <3C6FCBFD.80504@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Armin wrote:
> David Müller (ELSOFT AG) wrote:
>
>> Hello
>>
>>    - arch/ppc/kernel/ppc4xx_pic.c
>>       fixed constant in ppc405_pic_get_irq()
>>       (NR_IRQS is not necessarily the total number of UIC irqs)a
>
>
> hmmmmm... we should get ride of "NR_BOARD_IRQS" instead?
>

What do you mean by "get ride of "NR_BOARD_IRQS"".
Remove "NR_BOARD_IRQS" and the whole functionality behind of it
completely or just replace "NR_BOARD_IRQS" by a more meaningful name?


Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
