Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26CE61A0372
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 05:11:28 +1000 (AEST)
Date: Mon, 17 Aug 2015 21:11:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <matthew.r.wilcox@intel.com>,
 Dave Chinner <david@fromorbit.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ameen Ali <ameenali023@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Boaz Harrosh <boaz@plexistor.com>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@primarydata.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Matthew Wilcox <willy@linux.intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Mike Snitzer <snitzer@redhat.com>,
 Miklos Szeredi <mszeredi@suse.cz>, Ming Lei <ming.lei@canonical.com>,
 Omar Sandoval <osandov@osandov.com>, Paul Mackerras <paulus@samba.org>,
 Sagi Grimberg <sagig@mellanox.com>, Shaohua Li <shli@fb.com>,
 Tejun Heo <tj@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
 Yigal Korman <yigal@plexistor.com>, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 7/7] pmem, dax: have direct_access use __pmem annotation
Message-ID: <20150817191123.GE6752@lst.de>
References: <1439836211-4719-1-git-send-email-ross.zwisler@linux.intel.com>
 <1439836211-4719-8-git-send-email-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439836211-4719-8-git-send-email-ross.zwisler@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
