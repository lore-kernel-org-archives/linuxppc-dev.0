Message-ID: <005401c1ef2a$6e85ec60$71349ecd@mandy>
From: "Kevyn Shortell" <kevyn@mac.com>
To: <yellowdog-devel@lists.terrasoftsolutions.com>,
	<linuxppc-dev@lists.linuxppc.org>
References: <20020429004945.83544.qmail@web14804.mail.yahoo.com>
Subject: Re: Sungem with iMac Rev-B
Date: Sun, 28 Apr 2002 20:03:20 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In talking to BenH there is currently no way to do this. Nor are there public documents from Apple explaining how to do this.

As I've said previously, the fastest way to do this, is spend 20 or so, or alot of time, because there is no easy answer to this programatically.

Kevyn
----- Original Message -----
From: "Aurel Wisse" <aurel_wisse@yahoo.com>
To: <linuxppc-dev@lists.linuxppc.org>; "yddev" <yellowdog-devel@lists.terrasoftsolutions.com>
Sent: Sunday, April 28, 2002 5:49 PM
Subject: Sungem with iMac Rev-B


> Crossposted yellowdog-devel/linuxppc-devel, sorry but
> this is last ditch...
>
> I have read several comments about the sungem driver
> being preferred to the bmac(+) driver.
>
> Going through the sourcecode of the sungem, I am not
> sure however that it will work with older hardware
> like the iMac Rev-B's Uni-North and the LXT970.
>
> I am trying to modify the bmac to force the PHY to
> abandon autonegotiation and to use 10Mb/s and half
> duplex. "Reverse engineering" the bmac code leads
> nowhere. The bmac_init_phy doesn't give a lot of info,
> except a couple of undocumented constants written via
> bmac_mif_write, and the mif_write writes to the MIFCSR
> register which is undocumented in the bmac.h file.
>
> This is terribly frustrating as Apple is obviously
> able to do it with their Duplex tool hack. Hence, it
> *can* be done. Why can't they just send us their
> sourcecode for the Duplex tool? Does anybody have a
> direct line to Apple?
>
> Aurel
>
> _______________________________________________
> yellowdog-devel mailing list
> yellowdog-devel@lists.terrasoftsolutions.com
> http://lists.terrasoftsolutions.com/mailman/listinfo/yellowdog-devel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
