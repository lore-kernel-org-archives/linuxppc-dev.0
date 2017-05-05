Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wK3gj3W3GzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 17:39:29 +1000 (AEST)
Date: Fri, 5 May 2017 10:39:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: walter harms <wharms@bfs.de>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cxl: Unlock on error in probe
Message-ID: <20170505073907.wtuyp3ldbsytivhu@mwanda>
References: <20170505053622.0670F124037@b01ledav002.gho.pok.ibm.com>
 <a4c0a3f6-f631-0998-ddd0-ca2efd4f1bfd@au1.ibm.com>
 <590C2856.5070905@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <590C2856.5070905@bfs.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 05, 2017 at 09:23:02AM +0200, walter harms wrote:
> > sem is a global and it looks like it's intended to be held after
> > device_open() returns and only released in device_close(), so this looks
> > wrong.
> > 
> 
> the patch relates to the error path, do you expect a close() after the open() failed ?
> 

You can't close if open fails.  Please don't ask rhetorical questions.
Just state everything in short sentences using simple words.

regards,
dan carpenter
