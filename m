Message-ID: <XFMail.010502102553.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <20010501203224.16088@smtp.wanadoo.fr>
Date: Wed, 02 May 2001 10:25:53 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: slow ZIP
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>Why the ide ZIP drive is so slow ?  Raw transfer speed is only 150KB/s,
>>while it goes at ~1MB/s with MacOS.
>
> I don't think we let it do DMA because of limitations of older drive
> models. If we had infos about how to differenciate DMA-capable ZIPs
> from those older ones, then we could enable DMA by default.

Ok, but how can I enable DMA after boot ?  hdparm refuses to do it.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
