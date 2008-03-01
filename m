Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 109BDDDE45
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 13:04:43 +1100 (EST)
Date: Sat, 1 Mar 2008 03:04:33 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 1/3] firewire: fw-ohci: PPC PMac platform code
To: linux1394-devel@lists.sourceforge.net
In-Reply-To: <tkrat.7e8e04e66a38dcd6@s5r6.in-berlin.de>
Message-ID: <tkrat.22bd59f45b86b11c@s5r6.in-berlin.de>
References: <tkrat.ac97915a5b51e35b@s5r6.in-berlin.de>
	<tkrat.7e8e04e66a38dcd6@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote:
> +		struct device_node* ofn = pci_device_to_OF_node(dev);

-ECOPYANDWASTE:	struct device_node *ofn

-- 
Stefan Richter
-=====-==--- --== ----=
http://arcgraph.de/sr/
