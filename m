Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (lxorguk.ukuu.org.uk [81.2.110.251])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0ECFA1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 00:34:23 +1000 (EST)
Date: Wed, 27 Jun 2012 15:37:54 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 3/3] serial/8250: delete WR SBC850 UART quirk handling
Message-ID: <20120627153754.2a02896c@pyramind.ukuu.org.uk>
In-Reply-To: <4FEB1307.7060209@windriver.com>
References: <1340740469-31445-1-git-send-email-paul.gortmaker@windriver.com>
 <1340740469-31445-4-git-send-email-paul.gortmaker@windriver.com>
 <20120627125242.08a3114e@pyramind.ukuu.org.uk>
 <4FEB1307.7060209@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
 Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> I will, once Alpha is removed from the tree.  At the moment,
> it still uses it.

Ok I hadn't realised that.

Alan
