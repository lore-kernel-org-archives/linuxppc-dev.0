Message-ID: <20020718165403.51035.qmail@web20703.mail.yahoo.com>
Date: Thu, 18 Jul 2002 09:54:03 -0700 (PDT)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: Re: irq in Linux
To: Khai Trinh <kqtrinh@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020717213437.80862.qmail@web11504.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi guys,

U are right. U can have two or more than that irq in a
device driver. Let' say if u have

request_irq(irq no(17), handle1.....)
request_irq(irq no(18), handle2.....)
For os it does not matter from where u have
registered.
So whenever interrupt 17 will occur handle1 will be
executed...
in another case handle2......

So u can always do that...i guess so
bye
Bhupi

Deep into Silicon with linux...

www.gdatech.com
bhupi@gdatech.com
bhup_sah@yahoo.com




--- Khai Trinh <kqtrinh@yahoo.com> wrote:
>
> Hi folks,
>
> Can I register two devices irq numbers in a single
> device driver? If that's possible, then I can write
> a
> smart isr to figure out the interrupt is from which
> device and handle the irq accordingly.
>
> Any inputs would be appreciated...
>
> Thanks,
> --Khai
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
