Message-ID: <7143C7BA3BFAD2119AAC0008C7094B9965043E@postoffice2.teltronics.com>
From: Tom Miles <tmiles@teltronics.com>
To: "'Dan Malek'" <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Swap space on Embedded Planet CLLF 860
Date: Mon, 27 Mar 2000 16:06:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the reply...
I am running linuxplanet-2.2.13.  I have since learned that the 860T Rev B3
silicon has a bug in the data cache and since I disabled the data caching
the kernel is stable.

-----Original Message-----
From: Dan Malek [mailto:dan@netx4.com]
Sent: Monday, March 27, 2000 2:22 PM
To: Tom Miles
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Swap space on Embedded Planet CLLF 860


Tom Miles wrote:
>
> I have my CLLF 860 coming up via TFTP boot with a NFS mounted root file
> system.  The kernel crashes after a short while always in relation to a
page
> swap.

What kernel are you running and what patches did you apply?  This
happens when you screw up a PTE, and some of the MMU patches floating
around can cause this.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
