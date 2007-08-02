Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2CE6ADDDE9
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 08:37:23 +1000 (EST)
Subject: Re: [PATCH] Use 1TB segments
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: will_schmidt@vnet.ibm.com
In-Reply-To: <1186087283.22717.80.camel@farscape.rchland.ibm.com>
References: <18095.59959.698141.565343@cargo.ozlabs.ibm.com>
	<1186087283.22717.80.camel@farscape.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 03 Aug 2007 08:37:25 +1000
Message-Id: <1186094245.5495.637.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Is there technical reason why the 'local' variable remains at the end of
> the parm list for these?   In other cases 'ssize' simply gets added to
> the end of the parm list. 

Looks nicer to have psize and ssize together :-)

Ben.
