Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17792.37821.279813.601921@cargo.ozlabs.ibm.com>
Date: Thu, 14 Dec 2006 10:58:53 +1100
From: Paul Mackerras <paulus@samba.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: Bug: early_pfn_in_nid() called when not early
In-Reply-To: <20061213231717.GC10708@monkey.ibm.com>
References: <200612131920.59270.arnd@arndb.de>
	<20061213231717.GC10708@monkey.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	hch@infradead.org, linuxppc-dev@ozlabs.org,
	Michael Kravetz <mkravetz@us.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Kravetz writes:

> Thanks for the debug work!  Just curious if you really need
> CONFIG_NODES_SPAN_OTHER_NODES defined for your platform?  Can you get
> those types of memory layouts?  If not, an easy/immediate fix for you
> might be to simply turn off the option.

We really need CONFIG_NODES_SPAN_OTHER_NODES for pSeries.  Since we
can build a single kernel binary that runs on both Cell and pSeries,
the Cell code needs to be able to work with that option turned on.

Paul.
