Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 33583DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 18:40:18 +1000 (EST)
Date: Wed, 13 Jun 2007 10:40:23 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
Message-ID: <20070613084023.GA28629@aepfle.de>
References: <20070612181825.730300780@am.sony.com>>
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 13, Segher Boessenkool wrote:

> There is one real bug though.

Indeed.

> > +/ {
> > +	model = "PS3 Game Console";
> 
> model = "sony,some-model-number" or similar
> 
> > +	compatible = "PS3";
> 
> name = "sony,ps3"

Both are wrong.

Stick to the values used right now.
Which is 'PS3PF'
