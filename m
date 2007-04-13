Return-Path: <hch@lst.de>
Date: Fri, 13 Apr 2007 09:08:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [Cbe-oss-dev] [PATCH 3/4] cell: fix initialisation on systems
	with no SPEs
Message-ID: <20070413070804.GE13026@lst.de>
References: <1176428939.367182.371199141244.qpush@pokey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1176428939.367182.371199141244.qpush@pokey>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 13, 2007 at 11:48:59AM +1000, Jeremy Kerr wrote:
> This change fixes the case where spu_base and spufs are initialised on a
> system with no SPEs - unconditionally create the spu_lists so spu_alloc
> doesn't explode, and check for spu_management ops before starting spufs.

Ok.
