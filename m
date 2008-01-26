Return-Path: <rdreier@cisco.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Reminder: removal of arch/ppc
References: <E83C3B2F-0FC4-4248-B718-0C45B56E969A@kernel.crashing.org>
	<20080125192150.4cde6fac@zod.rchland.ibm.com>
	<adahch1jruv.fsf@cisco.com>
	<20080125202034.43556262@zod.rchland.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 25 Jan 2008 20:45:23 -0800
In-Reply-To: <20080125202034.43556262@zod.rchland.ibm.com> (Josh Boyer's
	message of "Fri, 25 Jan 2008 20:20:34 -0600")
Message-ID: <adad4rpjiu4.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > Hm.  Katmai is already in-tree.  Theoretically I should be able to get
 > the HW docs and do a new DTS and have it mostly "just work".  Perhaps
 > I'll give that a shot and have you give it a quick spin.

Yep, should be pretty easy.  A while back I built a Katmai kernel in
arch/ppc based on the Yucca support and the differences were pretty
trivial -- as I recall, the Katmai has compact flash support that the
Yucca doesn't have, and the Yucca has a simple little FPGA with a few
registers that controls power to the PCI slots.

 - R.
