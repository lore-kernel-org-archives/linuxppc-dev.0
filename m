Message-ID: <005901c0226f$775690d0$4d1f76d8@kennedy>
From: "Prashant Patel" <pmpatel@trinetcommunication.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Fw: 4MB DRAM is enough for linux kernel 2.2.13
Date: Tue, 19 Sep 2000 14:26:10 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: <kd@flaga.is>
To: Prashant Patel <pmpatel@trinetcommunication.com>
Sent: Tuesday, September 19, 2000 12:32 PM
Subject: Re: 4MB DRAM is enough for linux kernel 2.2.13


>
> Yes 4MB is enough but 8 or 16 is better it all depends on what you are
> going to run on your board.
> A running kernel needs between 1-2 MB for running it self (and a shell).
> the boot loader typically resides in flash and does not take space from
the
> running linux kernel.
>
> K.D.
>
>
>
> |--------+------------------------------------------>
> |        |          "Prashant Patel"                |
> |        |          <pmpatel@trinetcommunication.com|
> |        |          >                               |
> |        |          Sent by:                        |
> |        |          owner-linuxppc-embedded@lists.li|
> |        |          nuxppc.org                      |
> |        |                                          |
> |        |                                          |
> |        |          19.09.2000 17:03                |
> |        |                                          |
> |--------+------------------------------------------>
>
>---------------------------------------------------------------------------
--------------------------------|
>   |
|
>   |       To:     <linuxppc-embedded@lists.linuxppc.org>
|
>   |       cc:
|
>   |       Subject:     4MB DRAM is enough for linux kernel 2.2.13
|
>
>---------------------------------------------------------------------------
--------------------------------|
>
>
>
>
>
> Hello Everybody
>         Can someone tell me if 4MB DRAM is enough to boot linux kernel
> 2.2.13. Note that the 8xx rom boot loader occupies around 500k.
>
> Thanks
> Prashant Patel
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
