Return-Path: <greg@kroah.com>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9D014B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Mar 2012 02:19:02 +1100 (EST)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B5FEA2122E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2012 10:18:59 -0500 (EST)
Date: Fri, 9 Mar 2012 07:18:57 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 powerpc tree
Message-ID: <20120309151857.GA12578@kroah.com>
References: <20120309164025.dc16cfacaa2ee35cbeea14a8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120309164025.dc16cfacaa2ee35cbeea14a8@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 09, 2012 at 04:40:25PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the driver-core tree got a conflict in
> drivers/base/driver.c between commit fcd6f7620202 ("driver-core: remove
> legacy iSeries hack") from the powerpc tree and commit 9875bb480cc8
> ("Eliminate get_driver() and put_driver()") from the driver-core tree.
> 
> Just context changes.  I fixed it up (see below) and can carry the fix as
> necessary.

Looks good to me, thanks for doing this.

greg k-h
