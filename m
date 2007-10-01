Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5F51EDDE30
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 09:59:48 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l91Nxi96001762
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Oct 2007 19:59:44 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l91NxiJ8692896
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Oct 2007 19:59:44 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l91NxiTh014139
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Oct 2007 19:59:44 -0400
Subject: Re: [PATCH] PowerPC: Add RGMII support for Sequoia 440EPx
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <20071001141209.GA23971@ru.mvista.com>
References: <20071001141209.GA23971@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 01 Oct 2007 18:56:19 -0500
Message-Id: <1191282979.10089.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-10-01 at 18:12 +0400, Valentine Barshak wrote:
> This adds RGMII support to Sequoia DTS and sets correct phy-mode
> for EMACs. According to Sequoia datasheet, both ethernet ports
> are connected to RGMII interface, while ZMII is used only for MDIO.

I'm going to hold off on this one until the new EMAC driver is in Paul's
tree.

josh
