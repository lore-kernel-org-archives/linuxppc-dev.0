Message-ID: <006c01bffb67$fe4e2280$c2080b0a@huawei.com.cn>
From: "ligl" <sahala@sz.huawei.com.cn>
To: "Gabriel Paubert" <paubert@iram.es>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.HPX.4.10.10007311503090.9070-100000@gra-ux1.iram.es>
Subject: Re: Where do head.S initialize UART?
Date: Tue, 1 Aug 2000 11:24:25 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


initialize the UART at arch/ppc/8xx_io/uart.c
    rs_8xx_init()

>
> On Mon, 31 Jul 2000, Pei-Jie Hong wrote:
>
> >
> > I am porting Linux to a PowerPC VME board. I am now tracing head.S. Can
> > anyone
> > tell me where do head.S start to initialize the UART? Thanks.
>
> It does not, the UART basic setup should be done by the Firmware or
> perhaps by the initial bootloader. But otherwise it is postponed until
> the console is initialized.
>
> Regards,
> Gabriel.
>
>
> P.S: which VME board ? (I have a few Motorola's ones around 2400, and
> 2600)
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
