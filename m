MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Whate kind of kernel errors cause an Segmentation Fault
Date: Fri, 30 Mar 2001 14:32:48 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E310A9127@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Embedded Linux list" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


EFAULT i believe

check linux/include/asm/errno.h

K.D.

> -----Original Message-----
> From: Ralph Blach [mailto:rcblach@raleigh.ibm.com]
> Sent: 30. mars 2001 14:19
> To: Embedded Linux list
> Subject: Whate kind of kernel errors cause an Segmentation Fault
>
>
> What kind of kernel return codes will cause the C library to print out
> the message
>
> "Segmentation Fault"
>
> Thanks
>
> Chip
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
