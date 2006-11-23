Return-Path: <HNGUYEN@de.ibm.com>
In-Reply-To: <adaslgbaxsu.fsf@cisco.com>
Subject: Re: [PATCH 2.6.19] ehca: bug fix: use wqe offset instead wqe
	address	to determine pending work requests
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OFCFF36ACF.6FF07D9E-ONC125722F.00499C9C-C125722F.0049F685@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Thu, 23 Nov 2006 14:31:21 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <raisch@de.ibm.com>,
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

Hi Roland!
> OK.  After thinking about this, I'm going to queue it for 2.6.20 --
> we're _way_ too close to the 2.6.19 final release to put in patches
> that aren't either small and obvious, or fix a problem someone hit in
> real life.
That's fair. I understand your decision. And thanks for queueing for
2.6.20. Can you please brief me on patch procedures for post-2.6.19?
Regards
Nam
