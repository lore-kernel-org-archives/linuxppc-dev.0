Return-Path: <key@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 35C022C0083
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2012 01:49:18 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Mon, 24 Sep 2012 09:49:15 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DA46119D8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 09:48:34 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8OFmSCi206580
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 09:48:29 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8OFmS60028236
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 09:48:28 -0600
Date: Mon, 24 Sep 2012 10:48:21 -0500
From: key@linux.vnet.ibm.com
To: key@linux.vnet.ibm.com
Subject: Re: [PATCH 1/1] drivers/char/tpm: remove tasklet and cleanup
Message-ID: <20120924154821.GA16007@ennui.austin.ibm.com>
References: <1345670263.25124.7.camel@footlong>
 <1347472190.27058.5.camel@footlong>
 <alpine.LRH.2.02.1209241225230.678@tundra.namei.org>
 <20120924141041.GA2741@ennui.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120924141041.GA2741@ennui.austin.ibm.com>
Cc: rcj@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org,
 tpmdd-devel@lists.sourceforge.net, adlai@us.ibm.com,
 Ashley Lai <adlai@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 24, 2012 at 09:10:41AM -0500, key@linux.vnet.ibm.com wrote:
> On Mon, Sep 24, 2012 at 12:26:05PM +1000, James Morris wrote:
> > On Wed, 12 Sep 2012, Ashley Lai wrote:
> > 
> > > This patch removed the tasklet and moved the wait queue into the
> > > private structure.  It also cleaned up the response CRQ path.
> > > 
> > > Signed-off-by: Ashley Lai <adlai@us.ibm.com>
> > 
> > 
> > Kent: any comment on this?  You should probably push this to me via your 
> > tree.
> 
>   Oh, I thought we were waiting on Ben. This looks good to me, I'll get
> this to you today.

  Ashley tells me Ben's review is in the works, so I'll send once we
have it.

Kent

> 
>   Kent
> 
