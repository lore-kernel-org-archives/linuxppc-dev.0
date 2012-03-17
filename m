Return-Path: <grant.likely@secretlab.ca>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F8B7B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 18:27:27 +1100 (EST)
Received: by wgbds10 with SMTP id ds10so452039wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 00:27:23 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: issues calling of_platform_bus_probe() twice
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331933034.3105.171.camel@pasglop>
References: <31B4E554-FA95-431D-B353-92680CD14A0A@kernel.crashing.org>
 <1331933034.3105.171.camel@pasglop>
Date: Sat, 17 Mar 2012 07:27:17 +0000
Message-Id: <20120317072717.738953E08CE@localhost>
Cc: "devicetree-discuss@lists.ozlabs.org Discuss"
 <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 17 Mar 2012 08:23:54 +1100, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Fri, 2012-03-16 at 16:21 -0500, Kumar Gala wrote:
> > Guys,
> > 
> > Are you aware of any reason that we can't call of_platform_bus_probe()
> > or multiple times.  Timur's run into an issue in which all devices
> > don't get registered properly if we call of_platform_bus_probe() times
> > with different of_device_id struct's.
> 
> Nothing comes to mind... Grant ?

Neither for me.  Should work.

g.
