Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx1.americas.sgi.com (omx1-ext.sgi.com [192.48.179.11])
	by ozlabs.org (Postfix) with ESMTP id 6D89567D24
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 06:53:15 +1100 (EST)
Date: Mon, 30 Oct 2006 11:53:05 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2] Create compat_sys_migrate_pages.
In-Reply-To: <20061030181701.23ea7cba.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0610301152040.21342@schroedinger.engr.sgi.com>
References: <20061030181701.23ea7cba.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
	ak@suse.de, linux-mm@kvack.org, pj@sgi.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 30 Oct 2006, Stephen Rothwell wrote:

> This is needed on bigendian 64bit architectures.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Christoph Lameter <clameter@sgi.com>
