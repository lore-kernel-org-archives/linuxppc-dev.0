Message-ID: <3BE182BF.60009@mvista.com>
Date: Thu, 01 Nov 2001 12:13:35 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Sarnath Kannan <sparc64@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: "OpenPIC versus EPIC" in MPC8240 !
References: <20011101101302.15843.qmail@mailweb11.rediffmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sarnath Kannan wrote:

> Dear reader,
>  I am trying to enable interrupts on the sandpoint X2
> board hosting MPC8240, in Mode 1.

The Sandpoint interrupt structure for both X2 and X3 are supported
in the linuxppc kernel.  The MPC107/EPIC are supported on other boards
as well. Due to the way Linux supports interrupts, only one Sandpoint
board interrupt mode is supported.  Read the comments in
arch/ppc/kernel/sandpoint_setup.c for instructions.

There are many features of EPIC that are not currently supported using
the current OpenPIC functions, but it does work as a standard interrupt
controller on Sandpoint.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
