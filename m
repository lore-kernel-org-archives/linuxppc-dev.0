Return-Path: <glikely@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.177])
	by ozlabs.org (Postfix) with ESMTP id 89325DDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 02:26:21 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id c29so1616860ika
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 09:26:19 -0700 (PDT)
Message-ID: <528646bc0704160926i73c7976ree34564a113b3caf@mail.gmail.com>
Date: Mon, 16 Apr 2007 10:26:18 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>
Subject: Re: Mr Grant Likely's New Patches for 2.6 Kernel and Xilinx FPGA (
	Virtex-4 & Virtex-2
In-Reply-To: <4623A002.7080509@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY115-W1269AFE45FDEDFDEB86A99B2530@phx.gbl>
	<528646bc0704150727p1583132ck5455a36782e4dbcc@mail.gmail.com>
	<4623A002.7080509@ru.mvista.com>
Cc: Linux PPC <linuxppc-embedded@ozlabs.org>,
	Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/16/07, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
> Grant Likely wrote:
> > No, I did not include TEMAC support.  However, I will publish my git
> > tree tomorrow which will include the TEMAC driver.
>
>
> Seems the TEMAC driver is not on your git server yet. Hence the questions.
> Guess this is PLB TEMAC version 3.00a as you wrote auto negotiation is supported.

yup

> Is your driver based on the one by Xilinx (the one from EDK 8.2.02 and the update posted by Rick Moleres)?

Yup, it's just the adapter.c file that Rick posted plus some fixups to
get it to compile in my tree.  Nothing really exciting.  I'm very
interested in the phylib work that you've done.  I hope to take a look
at that in the next day or so.  I'm only publishing my tree as a
convienient starting point for those who need it.

Ideally, I'd like to look at doing a full rewrite so it's in a
condition acceptable for mainline, but I don't have time for that at
the moment.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
