Return-Path: <stern+4bbd8916@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by ozlabs.org (Postfix) with SMTP id 4DDA4B7D19
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Mar 2010 06:01:03 +1100 (EST)
Date: Fri, 19 Mar 2010 15:01:01 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [PATCH v5 00/10] wii: add usb 2.0 support
In-Reply-To: <1269023546-25534-1-git-send-email-albert_herranz@yahoo.es>
Message-ID: <Pine.LNX.4.44L0.1003191452310.18602-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, konrad.wilk@oracle.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 19 Mar 2010, Albert Herranz wrote:

> Alan: I think you are also working in a patchset to make {un}map_urb_for_dma
> remember how the urb was mapped, right?

Yes; you can see an initial version here:

	http://marc.info/?l=linux-usb&m=126901183419219&w=2

This is a bug fix, so it's likely to be merged before your work.

It's a messy situation, with two people changing the same code at the
same time.  I think the best approach will be to wait until the bug-fix
patch is tested and accepted; then I can create a version of your 5/10
and 6/10 patches adding HCD_NO_COHERENT_MEM and the corresponding
behavior.  That can stand by itself, and once it is accepted the rest
of your series should go through with no difficulty (at least, no
difficulties involving the USB core!).

Alan Stern
