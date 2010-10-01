Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.179.30])
	by ozlabs.org (Postfix) with ESMTP id 76291B70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 04:45:40 +1000 (EST)
Date: Fri, 1 Oct 2010 13:45:38 -0500
From: Robin Holt <holt@sgi.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 2/9] v3 Add mutex for adding/removing memory blocks
Message-ID: <20101001184538.GI14064@sgi.com>
References: <4CA62700.7010809@austin.ibm.com> <4CA62896.2060307@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CA62896.2060307@austin.ibm.com>
Cc: Greg KH <greg@kroah.com>, steiner@sgi.com, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	Robin Holt <holt@sgi.com>, linuxppc-dev@lists.ozlabs.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 01, 2010 at 01:29:42PM -0500, Nathan Fontenot wrote:
> Add a new mutex for use in adding and removing of memory blocks.  This
> is needed to avoid any race conditions in which the same memory block could
> be added and removed at the same time.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

Reviewed-by: Robin Holt <holt@sgi.com>

I am fine with this patch by itself, but its only real function is
to protect the count introduced by the next patch.  You might want to
combine the patches, but if not, that is fine as well.

Robin
