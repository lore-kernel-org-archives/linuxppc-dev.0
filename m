Date: Fri, 17 Sep 1999 20:34:53 -0500
From: Shaw Terwilliger <sterwill@io.nu>
To: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>
Cc: linuxdev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: unresolved symbol errors from insmod?
Message-ID: <19990917203453.A13773@io.nu>
References: <199909180118.SAA04037@falcon.csc.calpoly.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199909180118.SAA04037@falcon.csc.calpoly.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ira K Weiny wrote:
> 
> OK  I am still trying to get USB/PCI card on my PowerMac to work.  I have a
> lot of problems but this one seems totaly wrong to me.
> 
> [root@batcave2 USB-2.2]# insmod usb-ohci.o 

Have you tried (the automagically dependency-seeking) "modprobe" instead
of "insmod"?

-- 
Shaw Terwilliger (sterwill@io.nu)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
