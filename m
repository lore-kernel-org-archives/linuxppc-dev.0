Return-Path: <HNGUYEN@de.ibm.com>
In-Reply-To: <1184097931.3020.73.camel@localhost.localdomain>
Subject: Re: [PATCH] fix idr_get_new_above id alias bugs
To: jim.houston@ccur.com
Message-ID: <OF79FB2152.6DE55EBA-ONC1257315.006AAB0A-C1257315.006AE01D@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Wed, 11 Jul 2007 21:27:26 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, Christoph Raisch <raisch@de.ibm.com>,
	linuxppc-dev-bounces+hnguyen=de.ibm.com@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> With this patch, idr.c should work as advertised allocating id
> values in the range 0...0x7fffffff.  Andrew had speculated that
> it should allow the full range 0...0xffffffff to be used.  I was
> tempted to make changes to allow this, but it would require changes
> to API, e.g. making the starting id value and the return value
> unsigned.
Hi Jim, thanks much for this patch. It should work fine as far
as I can read. Will give it a try in next couple of days.
Nam
