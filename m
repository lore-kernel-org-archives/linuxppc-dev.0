Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0B7DB67BA1
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Jul 2005 01:41:54 +1000 (EST)
Date: Thu, 7 Jul 2005 08:41:52 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Scott Coulter <scott.coulter@cyclone.com>
Message-ID: <20050707154152.GB25876@gate.ebshome.net>
References: <43EB80E07C42E1408726E4905FB96B044404A6@CYBORG3.cyclone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43EB80E07C42E1408726E4905FB96B044404A6@CYBORG3.cyclone.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC440GX IBM EMAC2/3 RGMII mode selection
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jul 07, 2005 at 11:36:55AM -0400, Scott Coulter wrote:
> What about:
> 
> ocp_remove_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
> ocp_remove_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
> 
> dropped in xxx_setup_arch()?
> 

Of course, too early in the morning for me, I guess. I forgot I asked 
Matt to add this function :)

-- 
Eugene
