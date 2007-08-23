Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 3C345DDEFE
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 15:42:11 +1000 (EST)
Date: Thu, 23 Aug 2007 07:42:39 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: bogus vscsi dt node on iseries
Message-ID: <20070823054239.GA24251@aepfle.de>
References: <20070822175121.GA21233@aepfle.de>
	<20070823133621.830245c4.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070823133621.830245c4.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 23, Stephen Rothwell wrote:

> On Wed, 22 Aug 2007 19:51:21 +0200 Olaf Hering <olaf@aepfle.de> wrote:
> >
> > 
> > Does anyone know why dt_vdevices() creates a vscsi node on legacy iseries?
> > I'm sure only viodasd and viocd is required as blockdevice type.
> 
> Because the IBM vscsi client (in theory) works on legacy iSeries.

I'm asking because there are many unneeded nodes.
Have you tried to create only the nodes for disks/cds that are really
present and modify viodasd to use only device-tree data?
