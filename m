Message-ID: <3BD78E88.90337302@mvista.com>
Date: Thu, 25 Oct 2001 00:01:12 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Okehee Goh <ogoh@asu.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU in MBX860
References: <CPEELCODKANPCLBCAGOFKEBKCAAA.ogoh@asu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Okehee Goh wrote:

>  My question:
>  In MPC860, is there any way for supervisor mode's kernel to access all
> memory space

That's the purpose of the SHARED indicator in the TLB.  It effectively
disables ASID checking and if you mark pages SHARED but not user access
the kernel can access all pages while the applications are still protected.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
