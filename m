Date: Thu, 28 Oct 1999 13:04:35 -0500
From: Grant Erickson <grant@lcse.umn.edu>
To: Michael Fryar <mfryar@gcctech.com>
cc: linuxppc embedded mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: TiVo Kernel for 403GCX Update (was Re: Support for IBM CPUs?)
In-Reply-To: <B43E0634.1BD%mfryar@gcctech.com>
Message-ID: <Pine.SGI.4.10.9910281250430.695157-100000@sapphire.lcse.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 28 Oct 1999, Michael Fryar wrote:
> I have in my possession (hasn't been unpacked yet) a IBM PowerPC 405GP
> evaluation board kit. My goal is to get embedded Linux (w/ethernet
> networking) up a running on it. Unfortunately a few thing count against
> me:
> 
> 1) My use of Linux is from the user's perspective, not a kernel developer's.
> 2) My initiative is a "black" project (i.e. no support from my engineers).
> 3) I haven't coded seriously in years.

Please note that if your IBM PowerPC 405GP evaluation board uses Pass 1
silicon (PVR = 0x40110000), the MMU does not work in any way shape or
form. This will result in an effort to get stock Linux/PPC running on the
chip to end quickly. I think you'll have to wait until the 405GP has
release silicon.

> I hope your efforts (vis-a-vis the TiVo port) will find its way back into
> public distribution. This could provide the bedrock to get a 405 port
> started -- which in turn would be returned to public distribution.

My intentions are:

1. Get the TiVo Linux 2.1.24 code running and stable on IBM 403GCX
   evaluation board "Oak".

2. Port these changes forward to 2.3.x and stabilize.

3. Submit patches to Cort for inclusion into the Linux/PPC tree.

4. Port to IBM 405GP evaluation board "Walnut" when it's available.

5. Stabilize

6. Submit patches to Cort for inclusion into the Linux/PPC tree.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
