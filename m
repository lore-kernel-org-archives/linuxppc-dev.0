Message-ID: <3BBC927E.7F110817@mvista.com>
Date: Thu, 04 Oct 2001 12:46:54 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: ashish anand <ashisha@india.infogain.com>
Cc: "Prasad, Siva" <Siva.Prasad@smartm.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: EPIC <=> OpenPIC
References: <35C119252057D511BB9F0003476BF8A208E5DB@freexc01.smartm.com> <3BBBA395.3B812898@india.infogain.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ashish anand wrote:
>
> Yah..it is already available.
> Epic has been ported for MPC 107 and MPC 106 as well.
> for mpc 106 can refer montavista port .

The code for the EPIC on all devices is part of the linuxppc_2_4_devel
public source tree.  There is also an option to support the
serial interrupt communication mode if your hardware design
wishes to use that.

Just as Mark mentioned in a previous message, the EPIC works but
requires a clear understanding of how it was integrated into
the OpenPIC support.  Use an existing board port example as a guide.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
