Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BA00CDDEBF
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 08:40:50 +1000 (EST)
Date: Mon, 10 Sep 2007 17:41:36 -0500
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] export new __io{re,un}map_at() symbols
Message-ID: <20070910224136.GA28808@lixom.net>
References: <20070831035851.GA24414@lixom.net>
	<18149.48608.754709.782967@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18149.48608.754709.782967@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tue, Sep 11, 2007 at 07:57:52AM +1000, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > Export new __io{re,un}map_at() symbols so modules can use them.
> 
> What module wants to use these?  How is it going to work out what
> effective address to use?

electra_cf uses it, that driver is currently in -mm including below
update to use benh's rewritten interfaces:

http://patchwork.ozlabs.org/linuxppc/patch?id=13237

It gets the effective addresses to use out of the device tree.


-Olof
