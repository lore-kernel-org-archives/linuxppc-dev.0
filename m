Date: Sat, 7 Aug 2004 13:04:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Harald Welte <laforge@gnumonks.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] md raid autodetection on mac partitions
Message-ID: <20040807110404.GA1854@lst.de>
References: <20040806075918.GA11638@sunbeam2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040806075918.GA11638@sunbeam2>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 06, 2004 at 09:59:18AM +0200, Harald Welte wrote:
> Hi!
>
> It took me some time to discover that there is no provision in the mac
> parition handling code for autodetection of md raid arrays.
>
> Is there any particular reason why this isn't implemented?
>
> I've now added a new partition type 'Linux_raid_autodetect', which can
> be used for md autodetect.
>
> Please consider inclusion of this patch.

No.   raid autodetection is deprectaed, we don't want it for more
partiton types.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
