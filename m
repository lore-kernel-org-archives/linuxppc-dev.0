Message-Id: <sc834d4c.007@gw_tms_syd2.pty.tms.thomson-csf.com>
Date: Mon, 04 Mar 2002 10:32:40 +1100
From: "Jeremy Rosen" <Jeremy.Rosen@au.thalesgroup.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Accessing BCSR's
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everybody,

I have 860T FADS board, and I am trying to access the (board specific)
registers BCSRs.

I have no problem accessing them in PPCBOOT, since they are accessed
through CS1, at address FF01xxxx, but I can't access them in linux for
the moment.
My first attempt was by using the /dev/mem device, but it doesn't seem
to work, the result read are not correct.
so I have to question
1) why doesn't it work, I probably don't understand how /dev/mem works
: does it map only memory and not the address space ? do I have to
register the address range or the BCSR in the kernel ?
2) what is the proper way of doing this ? writing a driver ? or using
/dev/mem properly ?

thx for your help...

Jeremy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
