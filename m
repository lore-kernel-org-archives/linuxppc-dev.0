Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 62477B7D88
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jun 2010 15:41:05 +1000 (EST)
Received: by gwb15 with SMTP id 15so245890gwb.15
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 22:41:04 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <201006132112.36728.jeremy.kerr@canonical.com>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<1276311610.1962.173.camel@pasglop> <1276312071.1962.175.camel@pasglop>
	<201006132112.36728.jeremy.kerr@canonical.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 13 Jun 2010 23:40:43 -0600
Message-ID: <AANLkTimc84MnPvfZgVHoSkQuruS1KzLId_EgYl3DJn6w@mail.gmail.com>
Subject: Re: Request review of device tree documentation
To: Jeremy Kerr <jeremy.kerr@canonical.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Olof Johansson <olof@lixom.net>, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 13, 2010 at 7:12 AM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
> hi Ben,
>
>> Maybe a paragraph on the new proposed clock binding that Jeremy is
>> working would be of use btw.
>
> Here's one I prepared earlier:
>
> http://devicetree.org/ClockBindings

Yup, but the documents have difference purposes.  ClockBindings is the
formal description.  Device_Tree_Usage leads someone step by step how
everything actually fits together.  I think it would be useful to add
a clock binding section, especially with how important it is shaping
up to be for the ARM SoC work we're doing.

g.
