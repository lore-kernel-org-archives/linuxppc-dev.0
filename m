Message-ID: <396DF758.1576ECF4@alum.rit.edu>
Date: Thu, 13 Jul 2000 13:07:36 -0400
From: "Andrew W. Reynolds" <awreynolds@alum.rit.edu>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: zzh <david-1z@263.net>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Local sdram in 8260 board
References: <396D8712.26614@mta5> <396DE8B7.AD4CD03D@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This could be the setup of the SDRAM control word. When the cache is enabled it
begins bursting data from the SDRAM. When the SDRAM control word is not set to
burst 32 bytes it will cause the memory exception.

Dan Malek wrote:

> zzh wrote:
>
> > ...it will get machine check exception
> > at address 0x1000004 which is in the local sdram.When i disable the
> > cache ,it will work.
>
> It sounds like something is wrong with your memory controller
> configuration.  The cache enable/disable also affect the type of
> bus cycles that are used to access memory.
>
>         -- Dan
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
