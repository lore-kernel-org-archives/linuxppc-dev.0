Return-Path: <michel@tungstengraphics.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by ozlabs.org (Postfix) with ESMTP id 474E6DE028
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 00:27:38 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1919113fgg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 07:27:36 -0700 (PDT)
Subject: Re: pci issue - wrong detection of pci ressources
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <480DF46F.9090900@linux.vnet.ibm.com>
References: <48088F02.2060806@linux.vnet.ibm.com>
	<1208566122.6958.425.camel@pasglop>	<480BA937.7050603@linux.vnet.ibm.com>
	<1208727408.7009.0.camel@pasglop>	<480C80B6.30904@linux.vnet.ibm.com>
	<480C87BD.8090207@ru.mvista.com>	<480C9FE2.4030601@linux.vnet.ibm.com>
	<480CAFD2.2050108@ru.mvista.com> <480CBEE0.9000104@ru.mvista.com>
	<480DDE2B.4000808@linux.vnet.ibm.com> <480DE89B.2030402@ru.mvista.com>
	<480DF46F.9090900@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Apr 2008 16:27:31 +0200
Message-Id: <1208874451.5632.251.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-04-22 at 16:21 +0200, Christian Ehrhardt wrote:
> 
> >> radeonfb: EDID probed
> >> Parsing EDID data for panel info
> >> Setting up default mode based on panel info
> >> radeonfb (0000:00:0a.0): ATI Radeon Y`
> > 
> >    Hm, what's that Y`?
> 
> Thats the final message in the radeonfb driver ater initializing everything.
>    printk ("radeonfb (%s): %s\n", pci_name(rinfo->pdev), rinfo->name);
> I wonder why that rinfo->name is clobbered - maybe another issue, I
> have to keep that in mind.

It isn't clobbered, it's just the PCI device ID printed as characters.
That was a human readable string with early Radeons and thus convenient
for identifying them between humans, but that's no longer the case with
newer ones.


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
