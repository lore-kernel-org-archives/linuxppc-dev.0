Date: Wed, 9 Apr 2003 09:33:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Binh Nguyen <binh@us.ibm.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	linuxppc-users@lists.linuxppc.org
Subject: Re: Ethernet Driver Needed for IBM PPC 405 (Codename Walnut)
Message-ID: <20030408233356.GC13256@zax>
References: <OFA4C6E054.A1AC76DA-ON87256D02.00711FB1@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFA4C6E054.A1AC76DA-ON87256D02.00711FB1@us.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 08, 2003 at 04:45:47PM -0400, Binh Nguyen wrote:
>
> I heard that some one has written an ethernet driver for the IBM PPC 405
> board for Linux some time ago.  The author  has seen  performance
> improvement because the driver services interrupts in a better way.  If
> some one has a copy of the driver, would you please send it to
> binh@us.ibm.com.  Also any tips on how to install the driver is
> appreciated.  Thanks very much.

The driver is included in the linuxppc_2_4_devel and linuxppc-2.4
kernel trees.  You probably want to be using one of those trees in any
case.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
