Date: Tue, 4 Jun 2002 15:57:17 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Matt Porter <mporter@mvista.com>,
	ppc_devel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc_2_4_devel
Message-ID: <20020604155717.A22998@ecam.san.rr.com>
References: <20020604181844.00BFE10306@hostme.bitkeeper.com> <20020604155258.B22057@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020604155258.B22057@ecam.san.rr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 04, 2002 at 11:18:44AM -0700, ppc@bitkeeper.com wrote:
> ChangeSet
>   1.1069.1.2 02/06/04 10:47:24 mporter@beef.az.mvista.com +2 -0
>   Fix ibm_ocp_gpio so it can be used.
>
>   The header with ioctl defs is now exposed to userland and includes
>   linux/types.h so it will build there.

Looks like you missed a push for the new ioctl and linux/types.h
in the header file.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
