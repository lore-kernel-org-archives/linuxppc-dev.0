Return-Path: <thunderbird2k@gmail.com>
Received: from mail-ew0-f167.google.com (mail-ew0-f167.google.com
	[209.85.219.167]) by ozlabs.org (Postfix) with ESMTP id 92BBBDE19B
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 03:58:21 +1000 (EST)
Received: by ewy11 with SMTP id 11so1402129ewy.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 10:58:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090521165008.A020D710053@mail54-sin.bigfish.com>
References: <20090521162202.10880.34056.stgit@localhost.localdomain>
	<20090521162434.10880.62883.stgit@localhost.localdomain>
	<20090521165008.A020D710053@mail54-sin.bigfish.com>
Date: Thu, 21 May 2009 19:58:18 +0200
Message-ID: <c8485d470905211058t38d13d63n880c5c24cc0f5d94@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] powerpc/virtex: Add Xilinx ML510 reference
	designsupport
From: Roderick Colenbrander <thunderbird2k@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Yeow... I agree about the dirty hack part...  shouldn't this be in the
> device tree somewhere, or in the ali driver?
>
> I'm curious if this works on ml410 as well..  (Yes, I know, does this
> really matter much?  But there are still a bunch of them floating around
> in universities.)  It may be nice to factor this out so ml410/ppc405 and
> microblaze can get it as well.
>
> Steve

Yes the code can work one the ML410 as well. The thing is that you
would need a recent reference design from Xilinx. Before Xilinx used a
OPB pci bridge and these days they use a PLB (v46) pci bridge. The old
reference designs use the OPB core. I saw someone using a ML410
reference design which used the PBL pci soft-core and the same memory
addresses were even used as in the ml510 reference design I'm using.
I'm not sure where the guy got the design since the xilinx site only
shows old opb_pci stuff. (though the core is nearly the same) Further
most devices are also at the same locations on the pci bus.

Further the ml410 also offers good old lpt1 and some other things
which aren't on the ml510 but yes the pci code and big parts of the
dts file I wrote can be reused.

Roderick
