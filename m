Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD15467A5B
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 09:48:25 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2OMmC8g003514
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 17:48:12 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2OMm2JE231028
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 17:48:02 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2OMm2wF007875
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 17:48:02 -0500
Date: Fri, 24 Mar 2006 16:48:01 -0600
To: John Rose <johnrose@austin.ibm.com>
Subject: Re: [PATCH] powerpc: dynamic probe - use ppc_md.pci_probe_mode()
Message-ID: <20060324224801.GD26137@austin.ibm.com>
References: <1143220753.2567.22.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1143220753.2567.22.camel@sinatra.austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Paul Mackerras <paulus@samba.org>, External List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 24, 2006 at 11:19:13AM -0600, John Rose wrote:
> +	if (mode == PCI_PROBE_DEVTREE) {
> +		printk("%s: jhr: new probe\n", __FUNCTION__);

Did you intend to leave in this print statement?  Its looks
suspiciously like a  debug print.

--linas
