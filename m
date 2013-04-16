Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EA2E12C00EA
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 17:14:46 +1000 (EST)
Message-ID: <1366096475.24994.50.camel@pasglop>
Subject: Re: [PATCH 4/8] Read/Write oops nvram partition via pstore
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Tue, 16 Apr 2013 09:14:35 +0200
In-Reply-To: <516CEDB4.9090005@linux.vnet.ibm.com>
References: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
 <20130410072303.20150.61382.stgit@aruna-ThinkPad-T420>
 <20130415075555.GE30156@concordia> <516CEDB4.9090005@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-04-16 at 11:50 +0530, Aruna Balakrishnaiah wrote:
> 
> Sure. I will have one #ifdef for declarations and one for function
> definitions.

Declarations generally don't need #ifdef's

Cheers,
Ben.
 
