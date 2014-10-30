Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 632921A006B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 14:51:59 +1100 (AEDT)
Message-ID: <1414641117.12600.4.camel@concordia>
Subject: Re: FSL MSI Mapping
From: Michael Ellerman <mpe@ellerman.id.au>
To: Johannes Thumshirn <johannes.thumshirn@men.de>
Date: Thu, 30 Oct 2014 14:51:57 +1100
In-Reply-To: <20141028170604.GA1536@jtlinux>
References: <20141028170604.GA1536@jtlinux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, 'David Engster' <david.engster@mahr.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-10-28 at 18:06 +0100, Johannes Thumshirn wrote:
> Hi,
> 
> I got notified about your patch to support multiple MSI Vectors on Freescale
> PowerPC platforms. Is there any reason why it wasn't applied until now? I
> couldn't find anything about it in the list archives.
> 
> I think it would be a real benefit for all to have multiple MSI vecotrs on
> PowerPCs.

Why would you not use MSI-X ?

cheers
