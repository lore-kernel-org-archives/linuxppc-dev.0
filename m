Subject: RE: Going to sleep atomically
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 8 Mar 2001 14:12:43 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E3108AFB6@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Embedded Linux list" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Like in blocking read() and poll() etc?
interruptable_sleep_on()
or
sleep_on()

in poll() use poll_wait()

K.D.

P.S.
"Linux Device Drivers" by Rubini is an excellent guide to driver
writing, although
it is getting quite old (in kernel-time space).
Other drivers can serve as tutrials too.

K.D.

> -----Original Message-----
> From: Ralph Blach [mailto:rcblach@raleigh.ibm.com]
> Sent: 8. mars 2001 13:38
> To: Embedded Linux list
> Subject: Going to sleep atomically
>
>
> In a device driver, What is the best way to go to sleep atomically?
>
> Thanks
>
> Chip
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
