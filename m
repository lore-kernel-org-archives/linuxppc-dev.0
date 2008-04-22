Return-Path: <mike.koss@ngc.com>
Received: from xmrt0101.northgrum.com (xmrt0101.northgrum.com [208.20.220.55])
	by ozlabs.org (Postfix) with ESMTP id 74322DE030
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 08:15:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx PowerPC
Date: Tue, 22 Apr 2008 17:15:13 -0500
Message-ID: <EDAE140DF1B2FC42B5867C22CA0B333F0A5A42@XMBIL132.northgrum.com>
In-Reply-To: <480BD66B.90001@dlasys.net>
References: <480BA36D.1080000@dlasys.net>	<fa686aa40804201314m27caf4fau72956df9dd5d350d@mail.gmail.com>	<480BA821.2030109@dlasys.net><fa686aa40804201548o503e9b19p4081cec653a1acd2@mail.gmail.com>
	<480BD66B.90001@dlasys.net>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>,
	"Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have the start of a lltemac based on the new XPS_LL_TEMAC from EDK
9.2. I'm currently in the process of upgrading my design to 9.2. So I
will be very much interested in the driver working ;).

I'll see what I can get cleaned up and posted somewhere, if you'd like
to take a look at it.

-- Mike

(sorry for the double post, if it happens but it seems that my last
e-mail was blank per my records.)=20

-----Original Message-----
From: David H. Lynch Jr. [mailto:dhlii@dlasys.net]=20
Sent: Sunday, April 20, 2008 7:49 PM
To: Grant Likely
Cc: linuxppc-embedded
Subject: Re: Xilinx PowerPC

Thanks,

    I have alot of work to do on our stuff, I might as well see if I can
move to the powerpc tree at the same time.

    BTW is there even the beginings of a non-xilinx lltemac driver out
there ? There were hints on the list, but I have not seen anything.

    I would be happy to help advance the ball on anything anyone has
started.

  =20

Grant Likely wrote:
> On Sun, Apr 20, 2008 at 2:31 PM, David H. Lynch Jr. <dhlii@dlasys.net>
wrote:
>  =20
>> Thanks.
>>
>>     I am running linus's 2.6.25-rc9, but I can pull the Xilinx tree=20
>> or  yours - when your server is up.
>>
>>     I can not find any Xilinx powerpc configs in arch/powerpc/config
>>     Do I just need to do a
>>     make ARCH=3Dpowerpc menuconfig and create one from scratch ?
>>    =20
>
> That's right; I haven't merged any defconfigs.  Roll your own.
>
>  =20
>>     Is simpleboot in your tree or the xilinx tree, if  can not find=20
>> it  in Linus's ?
>>    =20
>
> If you want to use the "simpleboot" wrapper; then you'll need to pull=20
> paulus' tree (Linus hasn't yet pulled his tree; but he probably will=20
> any moment now).
>
> Cheers,
> g.
>
>  =20


--=20
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too
numerous to list.

"Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a lot of courage to move in the opposite
direction."
Albert Einstein
