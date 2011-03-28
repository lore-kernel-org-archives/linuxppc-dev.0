Return-Path: <sarah.a.sharp@linux.intel.com>
Date: Mon, 28 Mar 2011 15:16:05 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH 0/5] Make xHCI driver endian-safe, add a barrier, some
	debug
Message-ID: <20110328221605.GB8065@xanatos>
References: <4D8C47B0.1050104@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D8C47B0.1050104@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 25, 2011 at 06:43:44PM +1100, Matt Evans wrote:
> Hi Sarah,
> 
> 
> This series addresses the endian issues with the xHCI driver, and has brought
> lovely USB 3 to PPC. :-)  I've tested various types of traffic on ppc4xx and
> POWER7 and (some sound driver bugs notwithstanding) all seems fine.  Also
> addresses an ordering problem we found and the recursive nature of the event
> handling, plus the addition of some debug.

Thanks for doing this work, Matt!  I appreciate it.

> This should apply to 2.6.38/Linus' tree.

You say that these apply against 2.6.38, but recently a lot of xHCI
changes went into Linus' tree to support USB 3.0 hubs in 2.6.39.  Will
these patches still apply against Linus' latest tree?  If not, I suggest
you base your patches against Greg KH's usb-linus branch, as that's my
tree base:

http://git.kernel.org/?p=linux/kernel/git/gregkh/usb-2.6.git;a=shortlog;h=refs/heads/usb-linus

Also, I haven't read too far into the patches, but the first patch seems
to have several one or two letter variable names, like "f" and "di".
Can you make those variable names more descriptive?  Thanks.

Sarah Sharp
