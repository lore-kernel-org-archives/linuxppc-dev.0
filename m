Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18215.56691.666929.286619@cargo.ozlabs.ibm.com>
Date: Wed, 31 Oct 2007 12:42:11 +1100
From: Paul Mackerras <paulus@samba.org>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH] [powerpc v2] update xmon slb code
In-Reply-To: <20071030215037.12776.73871.stgit@farscape.rchland.ibm.com>
References: <20071030215037.12776.73871.stgit@farscape.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Will Schmidt writes:

> This adds a bit more detail to the xmon SLB output.  When the valid bit is
> set, This displays the ESID and VSID values, as well as decoding the
> segment size. (1T or 256M).  This supresses the output for any slb entries
> that contain only zeros.
> 
> sample output from power6 (1T segment support):
> 
> 00 c000000008000000 40004f7ca3000500  1T  ESID=   c00000  VSID=40004f7ca3 LLP bits:100

The "4" at the top of the VSID is actually the B (segment size) field,
isn't it?  Shouldn't that get masked off, since you have already
printed the segment size separately?

Also, if you removed the "bits" text, it would just about fit into 80
columns.  I think "LLP" is sufficient, the "bits" is redundant.

Apart from that it looks good.

Regards,
Paul,
