Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-39.bluehost.com (outbound-mail-39.bluehost.com
	[69.89.20.193]) by ozlabs.org (Postfix) with SMTP id A9ECFDDF50
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 07:37:12 +1000 (EST)
Message-ID: <480FAC0C.2050404@dlasys.net>
Date: Wed, 23 Apr 2008 17:37:16 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
Subject: Re: Xilinx PowerPC
References: <480BA36D.1080000@dlasys.net>	<fa686aa40804201314m27caf4fau72956df9dd5d350d@mail.gmail.com>	<480BA821.2030109@dlasys.net><fa686aa40804201548o503e9b19p4081cec653a1acd2@mail.gmail.com>
	<480BD66B.90001@dlasys.net>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A5A42@XMBIL132.northgrum.com>
In-Reply-To: <EDAE140DF1B2FC42B5867C22CA0B333F0A5A42@XMBIL132.northgrum.com>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Reply-To: dhlii@dlasys.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 I would be ecstatic to look at/collaborate on what you have.
I do not care if you clean it up. It can not be harder to work with than
my own code or the Xilinx code.

In the end I need Linux, GreenHills, as well as a lightweight stripped
driver for a monitor and embedded mini-web server.
I have all the above for the older PLB TEMAC in FIFO mode, but we are
moving to the LL TEMAC.

I started through the xilinx code and rapidly remembered how long it
took to demacrofy the xilinx PLB TEMAC code down to a single source file
with only
the code actually needed, and got depressed.

This is critical to us now, so I can put time into it.

If I can figure out how to bring up a git server on my hosting service I
am willing to host work on this -
though one of the existing trees might be a better choice.


Koss, Mike (Mission Systems) wrote:
> I have the start of a lltemac based on the new XPS_LL_TEMAC from EDK
> 9.2. I'm currently in the process of upgrading my design to 9.2. So I
> will be very much interested in the driver working ;).
>
> I'll see what I can get cleaned up and posted somewhere, if you'd like
> to take a look at it.
>
> -- Mike
>
> (sorry for the double post, if it happens but it seems that my last
> e-mail was blank per my records.) 
>
> -----Original Message-----
> From: David H. Lynch Jr. [mailto:dhlii@dlasys.net] 
> Sent: Sunday, April 20, 2008 7:49 PM
> To: Grant Likely
> Cc: linuxppc-embedded
> Subject: Re: Xilinx PowerPC
>
> Thanks,
>
>     I have alot of work to do on our stuff, I might as well see if I can
> move to the powerpc tree at the same time.
>
>     BTW is there even the beginings of a non-xilinx lltemac driver out
> there ? There were hints on the list, but I have not seen anything.
>
>     I would be happy to help advance the ball on anything anyone has
> started.
>
>    
>
> Grant Likely wrote:
>   
>> On Sun, Apr 20, 2008 at 2:31 PM, David H. Lynch Jr. <dhlii@dlasys.net>
>>     
> wrote:
>   
>>   
>>     
>>> Thanks.
>>>
>>>     I am running linus's 2.6.25-rc9, but I can pull the Xilinx tree 
>>> or  yours - when your server is up.
>>>
>>>     I can not find any Xilinx powerpc configs in arch/powerpc/config
>>>     Do I just need to do a
>>>     make ARCH=powerpc menuconfig and create one from scratch ?
>>>     
>>>       
>> That's right; I haven't merged any defconfigs.  Roll your own.
>>
>>   
>>     
>>>     Is simpleboot in your tree or the xilinx tree, if  can not find 
>>> it  in Linus's ?
>>>     
>>>       
>> If you want to use the "simpleboot" wrapper; then you'll need to pull 
>> paulus' tree (Linus hasn't yet pulled his tree; but he probably will 
>> any moment now).
>>
>> Cheers,
>> g.
>>
>>   
>>     
>
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
