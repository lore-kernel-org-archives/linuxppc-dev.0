Return-Path: <Johannes.Thumshirn@men.de>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.162])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DBEA1A0155
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 19:12:36 +1100 (AEDT)
Date: Fri, 31 Oct 2014 09:12:26 +0100
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Michael Ellerman <mpe@ellerman.id.au>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: FSL MSI Mapping
Message-ID: <20141031081225.GA20831@jtlinux>
References: <20141028170604.GA1536@jtlinux>
 <1414641117.12600.4.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1414641117.12600.4.camel@concordia>
Cc: Johannes Thumshirn <johannes.thumshirn@men.de>,
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
> cheers
>
>

Does anyone (especially the original author) have any objections if I re-spin
the patch series?
