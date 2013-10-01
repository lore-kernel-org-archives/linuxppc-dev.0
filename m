Return-Path: <michael@ellerman.id.au>
Date: Tue, 1 Oct 2013 14:12:29 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH 2/2] iommu: Update platform initialisation of iommu to
 use it_page_shift
Message-ID: <20131001041228.GB17966@concordia>
References: <1380599650-9541-1-git-send-email-alistair@popple.id.au>
 <1380599650-9541-3-git-send-email-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380599650-9541-3-git-send-email-alistair@popple.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 01, 2013 at 01:54:10PM +1000, Alistair Popple wrote:
> This patch initialises the iommu page size used for vio, cell, powernv
> and pseries platforms to 4K.  It has been boot tested on a pseries
> machine with vio.

This patch fixes the build errors introduced by the previous patch
right?

In which case you need to rework it so that you introduce the new
constants, use them everywhere, before removing the old constants. ie.
the build should never break.

cheers
