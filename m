Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80B9FDDDB2
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 09:10:32 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n45N5Wr8023159
	for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2009 19:05:32 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n45NAR8M147284
	for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2009 19:10:27 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n45NARIG025637
	for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2009 19:10:27 -0400
Date: Tue, 5 May 2009 19:09:19 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Fix wrong register read address and add interrupt
	acknowledge.
Message-ID: <20090505230919.GE14017@zod.rchland.ibm.com>
References: <20090505191116.GA7267@codiert.org>
	<ed82fe3e0905051224j30a54ef3s3d5e6c88987ea65a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed82fe3e0905051224j30a54ef3s3d5e6c88987ea65a@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 05, 2009 at 02:24:04PM -0500, Timur Tabi wrote:
>On Tue, May 5, 2009 at 2:11 PM, Benjamin Krill <ben@codiert.org> wrote:
>> The receive interrupt routine checks the wrong register if the
>> receive fifo is empty. Further an explicit interrupt acknowledge
>> write is introduced. In some circumstances another interrupt was
>> issued.
>
>The one-line summary of your patch is too vague.  It should mention
>the name of the driver somehow.

That is quite true.  Although resending the patch just for that seems overkill.
The maintainer can edit the summary rather easily.

josh
