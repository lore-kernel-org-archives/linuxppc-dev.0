Message-ID: <3D4714E7.9020003@dslextreme.com>
Date: Tue, 30 Jul 2002 15:36:23 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: device driver for ibm 440GP
References: <20020730215100.22006.qmail@web11504.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Khai Trinh wrote:
> Hi folks,
>
> Is there a 405GP/440GP char device driver sample out
> there I can use as a starting point for my custom
> driver? I am interrested in configuring the DMA
> controller code.
>
> Thanks,
> --Khai
>
>
>
>
>
>

look in drivers/ide/ocp_stbxxxxx.c for starters.  Are you looking for
scatter/gather support?

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
