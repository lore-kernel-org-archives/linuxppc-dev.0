Return-Path: <paulus@ozlabs.org>
Date: Thu, 29 Sep 2011 14:06:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Carl E. Love" <cel@linux.vnet.ibm.com>
Subject: Re: [PATCH REPOST] perf event, POWER 6: L1 cache read and write
	access event code fix]
Message-ID: <20110929040630.GB28110@bloggs.ozlabs.ibm.com>
References: <1317245013.5461.11.camel@oc5652146517.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317245013.5461.11.camel@oc5652146517.ibm.com>
Cc: linuxppc-dev@ozlabs.org, bherren@au1.ibm.com, pmac@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 28, 2011 at 02:23:33PM -0700, Carl E. Love wrote:
> The current L1 cache read event code 0x80082 only counts for thread 0. The
> event code 0x280030 should be used to count events on thread 0 and 1. The
> patch fixes the event code for the L1 cache read.
> 
> The current L1 cache write event code 0x80086 only counts for thread 0. The
> event code 0x180032 should be used to count events on thread 0 and 1. The
> patch fixes the event code for the L1 cache write.

Acked-by: Paul Mackerras <paulus@samba.org>
