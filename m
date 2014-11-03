Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0146.outbound.protection.outlook.com [157.56.111.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59C141A0179
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 08:57:34 +1100 (AEDT)
Message-ID: <1415051837.23458.272.camel@snotra.buserror.net>
Subject: Re: FSL MSI Mapping
From: Scott Wood <scottwood@freescale.com>
To: Johannes Thumshirn <johannes.thumshirn@men.de>
Date: Mon, 3 Nov 2014 15:57:17 -0600
In-Reply-To: <20141029065451.GA2441@jtlinux>
References: <20141028170604.GA1536@jtlinux>
 <1414523418.23458.98.camel@snotra.buserror.net>
 <20141029065451.GA2441@jtlinux>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
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

On Wed, 2014-10-29 at 07:54 +0100, Johannes Thumshirn wrote:
> On Tue, Oct 28, 2014 at 02:10:18PM -0500, Scott Wood wrote:
> > On Tue, 2014-10-28 at 18:06 +0100, Johannes Thumshirn wrote:
> > > Hi,
> > >
> > > I got notified about your patch to support multiple MSI Vectors on Freescale
> > > PowerPC platforms. Is there any reason why it wasn't applied until now? I
> > > couldn't find anything about it in the list archives.
> > >
> > > I think it would be a real benefit for all to have multiple MSI vecotrs on
> > > PowerPCs.
> >
> > Could you provide a patchwork link to the patch you're talking about?
> 
> Unfortunately I couldn't find it in the ppc patchwork, but here are the links to
> the patch series in the list archives:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-February/115484.html
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-February/115485.html
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-February/115486.html

They were in patchwork with changes requested in patch 1/2:
http://patchwork.ozlabs.org/patch/322497/
http://patchwork.ozlabs.org/patch/322334/

-Scott
