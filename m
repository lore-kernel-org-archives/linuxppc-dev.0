Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.179.29])
	by ozlabs.org (Postfix) with ESMTP id 57954B70FD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 04:54:07 +1000 (EST)
Date: Fri, 1 Oct 2010 13:54:04 -0500
From: Robin Holt <holt@sgi.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 5/9] v3 rename phys_index properties of memory block struct
Message-ID: <20101001185404.GL14064@sgi.com>
References: <4CA62700.7010809@austin.ibm.com> <4CA62982.5080900@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CA62982.5080900@austin.ibm.com>
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

On Fri, Oct 01, 2010 at 01:33:38PM -0500, Nathan Fontenot wrote:
> Update the 'phys_index' property of a the memory_block struct to be
> called start_section_nr, and add a end_section_nr property.  The
> data tracked here is the same but the updated naming is more in line
> with what is stored here, namely the first and last section number
> that the memory block spans.
> 
> The names presented to userspace remain the same, phys_index for
> start_section_nr and end_phys_index for end_section_nr, to avoid breaking
> anything in userspace.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

Reviewed-by: Robin Holt <holt@sgi.com>
