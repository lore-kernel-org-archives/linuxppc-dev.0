Return-Path: <jwboyer@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.247])
	by ozlabs.org (Postfix) with ESMTP id BBAADDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 22:10:51 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so335842hsz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Oct 2008 05:10:50 -0700 (PDT)
Date: Thu, 2 Oct 2008 08:09:36 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH]ppc4xx-Walnut: fixes early boot messages
Message-ID: <20081002120936.GA2316@yoda.jdub.homelinux.org>
References: <200810020736.40736.niklaus.giger@member.fsf.org>
	<20081002063954.GR25598@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081002063954.GR25598@yookeroo.seuss>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Niklaus Giger <niklaus.giger@member.fsf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 02, 2008 at 04:39:54PM +1000, David Gibson wrote:
>On Thu, Oct 02, 2008 at 07:36:40AM +0200, Niklaus Giger wrote:
>> Inherits the baudrate from U-boot to print things like:
>> Using Walnut machine description                                          
>> Linux version <..>
>> console [udbg0] enabled                                                                                       
>Uh.. but what if you're booting from cuboot or openbios, rather than a
>device-tree-aware uboot.

Right.  I don't think we want this particular change.  U-Boot can always
update it anyway.

josh
