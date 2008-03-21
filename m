Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id AED43DDFAB
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 21:54:51 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] Add AMCC Glacier 460GT eval board dts
Date: Fri, 21 Mar 2008 11:54:33 +0100
References: <1205943310-26323-1-git-send-email-sr@denx.de>
	<1206090031.8420.67.camel@pasglop>
In-Reply-To: <1206090031.8420.67.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200803211154.34027.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 21 March 2008, Benjamin Herrenschmidt wrote:
> On Wed, 2008-03-19 at 17:15 +0100, Stefan Roese wrote:
> > +               cpu@0 {
> > +                       device_type = "cpu";
> > +                       model = "PowerPC,460GT";
> > +                       reg = <0>;
>
> I wonder if we should do something here to differenciate the SoC chip
> from the core. After all, all those 4xx mostly have the same core (there
> are 2 or 3 revisions of the core maybe ...) but they tend to have all
> different PVR which is a pain and won't scale...
>
> Maybe AMCC could do something in HW (splitting the PVR from whatever
> indicates what "chip" it is, and keeping the PVR purely for the core
> rev) but I'm wondering if we should also do something in the DTS..
> Stefan can you talk to your AMCC contacts about this ?

Yes, I'll do that. Not sure about the outcome though.

> As for the DTS, maybe a "compatible" property in the CPU might make some
> sense with a content along the lines of "ppc440x6" or whatever rev of
> the 440 core it is.
>
> What do you think ?

Good idea. I'll try to come up with a list for all existing 4xx SoC's and it's 
core versions.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
