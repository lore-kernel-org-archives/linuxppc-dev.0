Message-ID: <3A6C7DB4.516E2897@mvista.com>
Date: Mon, 22 Jan 2001 13:36:36 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: michdaen@iiic.ethz.ch
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <3A686DFE.9030308@valinux.com> <19341214104258.22601@mailhost.mipsys.com> <3A68FC06.7BEEA13D@iiic.ethz.ch> <3A691166.DC6DCD81@iiic.ethz.ch> <3A6C6EEC.D1A84557@mvista.com> <3A6C7143.E49ADF33@relog.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:

> No, that's not the problem, pagelist is struct page ** :-/ (and pagelist is
> allocated)

Then, what the heck were you trying to print out with that
piece of code, and who further down the food chain uses
the page struct?


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
