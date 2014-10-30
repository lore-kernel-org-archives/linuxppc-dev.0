Return-Path: <Johannes.Thumshirn@men.de>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.118])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FDDB1A00AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 18:05:17 +1100 (AEDT)
Date: Thu, 30 Oct 2014 07:58:39 +0100
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: FSL MSI Mapping
Message-ID: <20141030065838.GA12301@jtlinux>
References: <20141028170604.GA1536@jtlinux>
 <1414641117.12600.4.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1414641117.12600.4.camel@concordia>
Cc: Johannes Thumshirn <johannes.thumshirn@men.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, 'David Engster' <david.engster@mahr.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 30, 2014 at 02:51:57PM +1100, Michael Ellerman wrote:
> On Tue, 2014-10-28 at 18:06 +0100, Johannes Thumshirn wrote:
> > Hi,
> >
> > I got notified about your patch to support multiple MSI Vectors on Freescale
> > PowerPC platforms. Is there any reason why it wasn't applied until now? I
> > couldn't find anything about it in the list archives.
> >
> > I think it would be a real benefit for all to have multiple MSI vecotrs on
> > PowerPCs.
>
> Why would you not use MSI-X ?
>

Simply because our hardware only supports MSI.
