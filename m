Message-ID: <407C0D33.20105@imc-berlin.de>
Date: Tue, 13 Apr 2004 17:54:27 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kfree_skb on hard IRQ ???
References: <407C065A.9010004@imc-berlin.de>
In-Reply-To: <407C065A.9010004@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

>
> Hi there,
>
> my HERMES-II drivers causes a lot of
>
> Warning: kfree_skb on hard IRQ c38c2168
>
> messages.
>
> What do they mean?

Is it enough to just replace dev_kfree_skb() with dev_kfree_skb_irq() ???

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
