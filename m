From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15726.62313.723964.671359@argo.ozlabs.ibm.com>
Date: Fri, 30 Aug 2002 14:24:09 +1000 (EST)
To: Matt Porter <porter@cox.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: set_cfg_type
In-Reply-To: <20020822170422.A2053@home.com>
References: <15716.30526.816418.995714@argo.ozlabs.ibm.com>
	<20020822170422.A2053@home.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter writes:

> I made it an option since we may get undesirable results fiddling
> with that bit on other host bridges.  We *could* leave it that
> way for safety sake on 2.4 and do it all the time on 2.5 and see
> what we break.  Recall that the PCI spec does not define host
> bridge operation, so the CFGA could do just about anything by
> twiddling that bit.

OK, then let's put the `set_cfg_type' field in the hose structure.  It
doesn't really belong in the ppc_md structure.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
