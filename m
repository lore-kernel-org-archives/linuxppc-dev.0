Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xM9jQ24ZhzDrHT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 19:18:33 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Shilpasri G Bhat' <shilpa.bhat@linux.vnet.ibm.com>,
 "stewart@linux.vnet.ibm.com" <stewart@linux.vnet.ibm.com>,
 "cyrilbur@gmail.com" <cyrilbur@gmail.com>
CC: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [RESEND][PATCH V10 0/3] powernv : Add support for OPAL-OCC
 command/response interface
Date: Tue, 1 Aug 2017 09:18:24 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0047F12@AcuExch.aculab.com>
References: <1501487009-16435-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1501487009-16435-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Shilpasri G Bhat
> Sent: 31 July 2017 08:43
> In P9, OCC (On-Chip-Controller) supports shared memory based
> commad-response interface. Within the shared memory there is an OPAL
      ^ typo
> command buffer and OCC response buffer that can be used to send
> inband commands to OCC. The following commands are supported:
...

	David
