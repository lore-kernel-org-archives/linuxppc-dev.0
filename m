Subject: Re: [PATCH] md raid autodetection on mac partitions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040806075918.GA11638@sunbeam2>
References: <20040806075918.GA11638@sunbeam2>
Content-Type: text/plain
Message-Id: <1093731673.2638.189.camel@gaston>
Mime-Version: 1.0
Date: Sun, 29 Aug 2004 08:21:13 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-08-06 at 17:59, Harald Welte wrote:
> Hi!
>
> It took me some time to discover that there is no provision in the mac
> parition handling code for autodetection of md raid arrays.
>
> Is there any particular reason why this isn't implemented?
>
> I've now added a new partition type 'Linux_raid_autodetect', which can
> be used for md autodetect.

Hi Harald, just found this patch, sorry for the delay.

Why just not "Linux_raid" ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
