Message-ID: <3F72B028.80404@bluewin.ch>
Date: Thu, 25 Sep 2003 11:06:48 +0200
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Christophe.LINDHEIMER@fr.thalesgroup.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Driver with floats.
References: <66CE949D18BCB249ABE8D9AF48C4F1CE7776D5@helios.gnv.tcc.thomson-csf.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 09/25/2003 10:45 AM Christophe.LINDHEIMER@fr.thalesgroup.com wrote:
> Hi.
>
> I would like to know if it is possible to use floats in a kernel driver.
> I use a MPC860.
> I get unresolved symbols with the standard makefile.
> Are there special options to use ?
> Any lib to add ?

We have a demo module for RTAI using soft-floats on MPC 8xx at
ftp://ftp.denx.de/pub/RTAI/contrib/fp_ppc_8xx.tar.bz2. There is a README
inside. But be aware that soft-float on the 860 is very slow, especially
when you do complex FP math like sin() etc.

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
