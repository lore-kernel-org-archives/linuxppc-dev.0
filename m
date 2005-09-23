Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 89DFE68352
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 13:22:39 +1000 (EST)
Date: Thu, 22 Sep 2005 20:22:36 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Roland Dreier <rolandd@cisco.com>
Message-ID: <20050923032236.GA10089@gate.ebshome.net>
References: <2005922203.UPGbNSgrHKasoXYq@cisco.com>
	<2005922203.qtfGFmWm3E8jkhq1@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2005922203.qtfGFmWm3E8jkhq1@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 3/4] [PPC32] ibm_emac: Add 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 22, 2005 at 08:03:35PM -0700, Roland Dreier wrote:
> Eugene, I'm not sure what the status of your ibm_emac rewrite is.  Is
> there a tree somewhere that you would like me to merge this change
> with and then send you a patch, or do you want to take care of merging?

Well, new driver was sent to jgarzik and netdev list three weeks ago. 
So far I haven't heard anything technical from Jeff. I don't know when 
and even if it will be merged.

There is a GIT tree with new driver, for more info look at 
http://kernel.ebshome.net/emac/index.html

I don't know what to recommend now - wait for net driver maintainer 
(I've heard some people have been waiting for couple months already) 
or sent this patch upstream ignoring new driver :(. Matt?

I'll try to look at merging your patch into my tree, but probably not 
right now - I'm kinda busy with other stuff and netdev "progress" 
doesn't quite motivate me working on this project, frankly. Though, if 
you can send me a patch against my tree, I'll appreciate it :).

-- 
Eugene
