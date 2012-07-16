Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e2.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2330F2C0203
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 07:29:57 +1000 (EST)
Received: from /spool/local
 by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 16 Jul 2012 17:29:54 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 1B5806E8060
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2012 17:25:41 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6GLPeuE171002
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2012 17:25:40 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6GLPd2e023355
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2012 15:25:40 -0600
Date: Mon, 16 Jul 2012 14:25:51 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH 1/2] power: Define PV_POWER7P
Message-ID: <20120716212551.GA14163@us.ibm.com>
References: <20120712235912.GA19909@us.ibm.com>
 <20120713064605.GA11030@visitor2.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120713064605.GA11030@visitor2.iram.es>
Cc: michaele@au1.ibm.com, Anton Blanchard <anton@au1.ibm.com>,
 sukadev@us.ibm.com, linuxppc-dev@ozlabs.org, cel@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gabriel Paubert [paubert@iram.es] wrote:
| > +#define PV_POWER7P	0x004A
| >  #define PV_630		0x0040
| >  #define PV_630p	0x0041
| >  #define PV_970MP	0x0044
| 
| Hmm, before this patch the PVR definitions were sorted in ascending
| numerical order, at least for the list of 64 bit processors. Your
| patch breaks this, which is not a good idea IMHO. 
| 
| For example, the 970* processors are already interspersed with other
| processors to maintain numerical order, therefore I don't see why the 
| POWER7P could not be between 970GX and BE.
| 
| Another inconsistency is that all other "plus" variants seem to 
| use a lower case "p" suffix. So it would be better to use POWER7p.

Agree with both your points above. I re-sent the patches with updates.

Sukadev
