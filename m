Subject: RE: uart.c
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 25 Jul 2001 13:46:34 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31459226@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Cc: <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Kári Davíðsson
> Sent: 25. júlí 2001 11:10
> To: Linux Embedded ppc (E-mail)
> Subject: uart.c
>
>
>
> Hi,
>
> Is there any reason for the USB client code to exclude smc1 port
                                                         ^^^^
should be smc2

> (/dev/ttyS1) in uart.c?
>
> K.D.
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
