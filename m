Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Subject: RE: Wolfgang's updates 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 13 Mar 2001 09:49:21 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E3108AFC4@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> -----Original Message-----
> From: Wolfgang Denk [mailto:wd@denx.de]
> Sent: 12. mars 2001 21:58
> To: Dan Malek; Tom Rini
> Cc: linuxppc-dev@lists.linuxppc.org
> Subject: Re: Wolfgang's updates

[SNIP]

> Ummm... The flash stuff is just adding NEW files. The fact they  have
> been tested on PPC only should not create a problem adding the files.
> Many people add x86 drivers that don't work on PPC ;-)

[SNIP]

> * AMD   flash chip support
> * INTEL flash chip support

[SNIP]

>   PCMCIA port, and for real PCCARD interfaces like CompactFlash or
>   harddisk adapter cards, but without need for the full PCMCIA
>   package; also usable for boot devices).
>

Isn't this exactly what mtd is dooing, i.e. generating a general
interface to flash devices.
Isn't this a duplication of work, and deemed to be rejected from the
official kernel because the mtd is allready in the official kernel?

K.D.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
