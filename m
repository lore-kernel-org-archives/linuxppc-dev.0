Message-Id: <5.0.2.1.0.20010628105509.02f18120@pop.gmx.de>
Date: Thu, 28 Jun 2001 10:57:40 +0800
To: Matthew Locke <mlocke@mvista.com>
From: Michael Habermann <MHabermann@gmx.de>
Subject: Re: Segmentation fault while dynamic linking
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3B3A1328.6000602@mvista.com>
References: <3B39524B.5090108@mvista.com>
 <32197.993642129@www29.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:08 AM 6/27/2001 -0700, Matthew Locke wrote:

>There are two places cacheline size affects glibc.  The one above that
>you already found and in the glibc ppc optimized memset or memcpy (don't
>remember which one).  you can just delete the ppc specific memset and
>configure will pull in the generic memset.

Yeah, deleting memset.S solved my problem.

Thanks to you and the guys who answered by private mail.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
