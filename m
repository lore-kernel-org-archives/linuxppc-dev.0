Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6FBEF2C008C
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2012 13:08:51 +1000 (EST)
Message-ID: <1343704122.8227.3.camel@pasglop>
Subject: Re: [PATCH] scsi/ibmvscsi: add module alias for ibmvscsic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian J King <bjking1@us.ibm.com>
Date: Tue, 31 Jul 2012 13:08:42 +1000
In-Reply-To: <20120730190606.GD3155@aepfle.de>
References: <1342630158-16510-1-git-send-email-olaf@aepfle.de>
 <1343611946.21647.23.camel@pasglop> <20120730190606.GD3155@aepfle.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
 linux-scsi@vger.kernel.org, "James E.J. Bottomley" <JBottomley@parallels.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-30 at 21:06 +0200, Olaf Hering wrote:
> > So while this would work, I do wonder however whether we could
> instead
> > fix it by simplifying the whole thing as follow since iSeries is now
> > gone and so we don't need split backends anymore:
> > 
> > scsi/ibmvscsi: Remove backend abstraction
> 
> I cant that these things myself anymore.

Brian, can somebody from your side own these ?

Cheers,
Ben.
