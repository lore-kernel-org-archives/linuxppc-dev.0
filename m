Return-Path: <tytso@thunk.org>
Received: from imap.thunk.org (imap.thunk.org
 [IPv6:2600:3c02::f03c:91ff:fe96:be03])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHsbS2GXpzDvgC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 14:01:08 +1100 (AEDT)
Date: Mon, 14 Nov 2016 21:24:20 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 linux-ext4@vger.kernel.org, jack@suse.cz,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ext4: ext4_mb_mark_free_simple: Fix integer value
 truncation
Message-ID: <20161115022420.7bgsyq3yz6sxv3sk@thunk.org>
References: <1478164472-28376-1-git-send-email-chandan@linux.vnet.ibm.com>
 <2AE0DCBF-5AB6-47B2-B9F6-B738AFF2EAF2@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2AE0DCBF-5AB6-47B2-B9F6-B738AFF2EAF2@dilger.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 03, 2016 at 01:32:33PM -0600, Andreas Dilger wrote:
> On Nov 3, 2016, at 3:14 AM, Chandan Rajendra <chandan@linux.vnet.ibm.com> wrote:
> > 
> > 'border' variable is set to a value of 2 times the block size of the
> > underlying filesystem. With 64k block size, the resulting value won't
> > fit into a 16-bit variable. Hence this commit changes the data type of
> > 'border' to 'unsigned int'.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Applied, with a change in the commit summary:

    ext4: fix mballoc breakage with 64k block size

Many thanks!!

					- Ted
