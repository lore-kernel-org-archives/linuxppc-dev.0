Message-Id: <5.1.0.14.2.20011030135242.026ae340@falcon.si.com>
Date: Tue, 30 Oct 2001 13:54:48 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: PPC 405 Register Model
In-Reply-To: <3BD813CE000007B2@charlotte.ccc-dcs.com> (added by
  charlotte.ccc-dcs.com)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It's in the specs ABI/EABI ([Embedded] Application Binary Interface).  All
compilers I have run across support EABI by default.
   http://www.esofta.com/softspecs.html

gvb


At 11:58 AM 10/30/01 -0600, you wrote:

>I'm needing to do some inline assembly for the Walnut board running MVista's
>Hard Hat Linux and I'm concerned about clobbering registers.  Can someone
>point me to docs or source code that describes the register usage of HHL on
>the 405GP?
>
>Thanks,
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
