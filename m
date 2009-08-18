Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BA7DBB6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 23:28:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7IDSR6o015795
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2009 09:28:27 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7IDScbO221586
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2009 09:28:38 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7IDScWM006533
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2009 09:28:38 -0400
Date: Tue, 18 Aug 2009 09:28:35 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: powerpc/405ex: Support cuImage for PPC405EX
Message-ID: <20090818132835.GA2530@zod.rchland.ibm.com>
References: <1250562484-16415-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250562484-16415-1-git-send-email-tiejun.chen@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 18, 2009 at 10:28:02AM +0800, Tiejun Chen wrote:
>Summary: powerpc/405ex: Support cuImage for PPC405EX
>Reviewers: Benjmain and linux-ppc
>----------------------------------------------------
>These patch series are used to support cuImage on the kilauea board based on PPC405ex.
>
>Tested on the amcc kilauea board:

Hm.  The U-Boot version that ships on the AMCC Kilauea board is FDT aware, so
cuImage shouldn't be needed at all.  I'm slightly confused why we need this.
Are you using it for some other board derived from 405EX that doesn't have
an FDT aware U-Boot?

josh
