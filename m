Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94013DDED1
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 08:54:13 +1000 (EST)
Message-Id: <C24AB05C-E10D-47F1-A605-C30D4093699C@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Philippe De Muyter <phdm@macqel.be>
In-Reply-To: <20080311114601.GA19189@netgate.macqel>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Date: Tue, 6 May 2008 17:54:02 -0500
References: <20080304080828.GA18829@netgate.macqel>
	<1204618939.21545.52.camel@pasglop>
	<20080304091059.GD18829@netgate.macqel>
	<1204693264.21545.165.camel@pasglop>
	<47CECB21.3060704@freescale.com>
	<1204760811.21545.231.camel@pasglop>
	<20080307001025.GA27321@netgate.macqel>
	<1204849197.21545.272.camel@pasglop>
	<20080309223109.GA3989@netgate.macqel>
	<20080311003249.GG11559@localhost.localdomain>
	<20080311114601.GA19189@netgate.macqel>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Now back to the first an bigger problem :
> currently, I have an "old" U-boot and I have written myself a dts  
> file.
>
> Problem is : ethernet does not work, but that's not a mac-address  
> problem,
> but something else that I do not understand yet.  The symptom is I get
>
> 	ip route add default via 192.168.85.33 dev eth0
> 	RTNETLINK answers: Network is unreachable
>
> I surmise this is because my eth0 does not become up, and I surmise
> again this is because there is no driver selected to drive the phy.
>
> In my arch/ppc setup this was automagically handled by fixed@100:1  
> IIRC
>
> Is there something I can put in my dts file to activate a driver for  
> my phy ?
>
> Best regards

This slipped under my radar, and I'm only just now finding it again.   
Have your issues been resolved?  If not, could you send a bit more of  
the boot log?  There should be a little more if the PHY was not  
found.  If you were operating with a fixed PHY setup before, then the  
generic PHY driver (which will automatically bind to your PHY) should  
suffice unless your MDIO bus is broken.

Andy
