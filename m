Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@vanet.com.br>
To: Ken Applebaum <applebaumk@embeddedplanet.com>
Subject: Re: Linuxppc and MPC8255 routing performance
Date: Tue, 13 Nov 2001 14:03:48 +0300
References: <D73A25AA6E54D511AD74009027B1110F04F5E1@ORION>
In-Reply-To: <D73A25AA6E54D511AD74009027B1110F04F5E1@ORION>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <01111314034801.01064@scop.digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Ken

On Monday 12 November 2001 18:28, Ken Applebaum wrote:
> ricardo,
>
> does your board have both banks of memory populated?
>

If you mean 'both banks" as a memory bank at the local bus and another at the
60x bus, the answer is yes, our prototype hardware has them, for hardware
debugging purposes. But I didn't enable the use of the local memory bank in
Linux so far, because we didn't originally intend to use it in our final
product...

Nevertheless, I'm aware that using local bus memory for I/O data flowing
between CPM and CPU may improve performance in some Linux applications, so I
would like to experiment with this. Unfortunatelly, I'm very new to Linux, so
I don't know how to configure it for using local memory. If you have any
ideas...

Thanks.

~Ricardo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
