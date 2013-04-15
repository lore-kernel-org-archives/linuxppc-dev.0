Return-Path: <michael@ellerman.id.au>
Date: Mon, 15 Apr 2013 15:01:30 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Zhenhua Luo <zhenhua.luo@freescale.com>
Subject: Re: [PATCH] Enable CONFIG_DEVTMPFS_MOUNT to ensure /dev can be
 mounted correctly
Message-ID: <20130415050129.GB21147@concordia>
References: <1365688591-5323-1-git-send-email-zhenhua.luo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365688591-5323-1-git-send-email-zhenhua.luo@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 11, 2013 at 09:56:30PM +0800, Zhenhua Luo wrote:
> When using recent udev, the /dev node mount requires CONFIG_DEVTMPFS_MOUNT
> is enabled in Kernel.

Really?

I know it makes life easier when you don't have an initramfs, but is it
actually required now?

cheers
