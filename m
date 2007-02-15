Return-Path: <HNGUYEN@de.ibm.com>
In-Reply-To: <adazm7fs3qb.fsf@cisco.com>
Subject: Re: [PATCH 2.6.21-rc1 4/5] ehca: replace yield()
	by	wait_for_completion()
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OFAA6668FF.C2E1DD58-ONC1257283.006C7A81-C1257283.006D6172@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Thu, 15 Feb 2007 20:54:43 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: bos@patchscale.com, heicars2@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, openib-general@openib.org,
	hch@infradead.org, linuxppc-dev@ozlabs.org,
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

Hi,
> So I'm holding off on applying this for now.  Please think it over and
> either tell me the current patch is OK, or fix it up.  There's not
> really too much urgency because a change like this is something I
> would be comfortable merging between 2.6.21-rc1 and -rc2.
You're absolutely right. Let's target for rc2.
Thanks for this good catch!
Nam
