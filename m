Return-Path: <hch@lst.de>
Date: Tue, 15 Nov 2005 10:20:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kumar Gala <galak@gate.crashing.org>
Message-ID: <20051115092042.GA2060@lst.de>
References: <Pine.LNX.4.44.0511141721190.9033-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0511141721190.9033-100000@gate.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: put page page_to_virt for Book-e processors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 14, 2005 at 05:21:44PM -0600, Kumar Gala wrote:
> Book-E processors use page_to_virt since we have to always translate.

Why can't you use the proper page_address() macro?
