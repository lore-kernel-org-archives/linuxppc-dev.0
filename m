Message-ID: <384AFB2B.715EECB6@syseng.anu.edu.au>
Date: Mon, 06 Dec 1999 10:54:19 +1100
From: Peter Brown <pfb@syseng.anu.edu.au>
MIME-Version: 1.0
To: Ole.Reinartz@nokia.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Math Emulation again
References: <A914533BF4B9D2118D980008C7894C0A014D54F0@dueis01nok>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone tried writing a driver for the MPC860 CPM DSP?  The Motorola FAQ
says that it can perform an 8x8 pixel Discrete Cosine Transform in 30uS (@
25Mhz clock speed).  The MPC823 has a DSP coprocessor in it as well.  The
MPC860 DSP library is targeted for modem processing but could be used for
other purposes.  
-- 
Peter Brown, Software Engineer      | Phone: +61 2 6279 8830
Robotic Systems Lab, RSISE          | Fax:   +61 2 6279 8660
Australian National University      | 
Canberra ACT 0200 AUSTRALIA         |
--------------------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
