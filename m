Return-Path: <HNGUYEN@de.ibm.com>
In-Reply-To: <adaps96n4rl.fsf@cisco.com>
Subject: Re: [PATCH 2.6.20 2/2] ehca: ehca_irq.c: fix mismatched
	spin_unlock	in irq handler
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OF28705E47.AADA4E8C-ONC125726B.00756FD8-8525726B.00766A6A@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Mon, 22 Jan 2007 16:33:25 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	openfabrics-ewg@openib.org, linuxppc-dev@ozlabs.org,
	Christoph Raisch <raisch@de.ibm.com>,
	linuxppc-dev-bounces+hnguyen=de.ibm.com@ozlabs.org,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I think the right thing to do is restructure this function so you
> don't have lines starting 6 tab stops to the right.
Yes. Have reworked this irq handler and still struggling with testing.
When we feel comfortable with the test result, we'll post it here (soon)
and hopefully it is easier to read.
Regards
Nam
