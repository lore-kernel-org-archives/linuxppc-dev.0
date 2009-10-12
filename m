Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92195B7B69
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 23:34:20 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9CCWxQR021525
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 08:32:59 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9CCYGwP161322
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 08:34:16 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9CCYFoq030048
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 08:34:15 -0400
Date: Mon, 12 Oct 2009 08:34:12 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Niklaus Giger <niklaus.giger@member.fsf.org>
Subject: Re: [PATCH] powerpc/40x: Cleanups for HCU4 board
Message-ID: <20091012123412.GE22408@zod.rchland.ibm.com>
References: <1255117658-3889-1-git-send-email-niklaus.giger@member.fsf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1255117658-3889-1-git-send-email-niklaus.giger@member.fsf.org>
Cc: linuxppc-dev@ozlabs.org, niklaus.giger@netstal.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 09, 2009 at 09:47:38PM +0200, Niklaus Giger wrote:
>- hcu4.dts: Added definitions for 2 CAN (Intel 82527)
>- hcu4.c: Some code for CPLD (special HW clock) and 2 CAN (Intel 82527)

Same comments here as in the HCU5 patch.  Drop the device_type for cpld and
can, and use compatible properties please.

josh
