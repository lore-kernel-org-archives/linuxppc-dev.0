Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-09.bluehost.com (outbound-mail-09.bluehost.com
	[69.89.17.209]) by ozlabs.org (Postfix) with SMTP id 54FD0DE201
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Apr 2008 09:55:43 +1000 (EST)
Message-ID: <480BD66B.90001@dlasys.net>
Date: Sun, 20 Apr 2008 19:48:59 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Xilinx PowerPC
References: <480BA36D.1080000@dlasys.net>	
	<fa686aa40804201314m27caf4fau72956df9dd5d350d@mail.gmail.com>	
	<480BA821.2030109@dlasys.net>
	<fa686aa40804201548o503e9b19p4081cec653a1acd2@mail.gmail.com>
In-Reply-To: <fa686aa40804201548o503e9b19p4081cec653a1acd2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Thanks,

    I have alot of work to do on our stuff, I might as well see if I can
move to the powerpc tree at the same time.

    BTW is there even the beginings of a non-xilinx lltemac driver out
there ? There were hints on the list, but I have not seen anything.

    I would be happy to help advance the ball on anything anyone has
started.

   

Grant Likely wrote:
> On Sun, Apr 20, 2008 at 2:31 PM, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>   
>> Thanks.
>>
>>     I am running linus's 2.6.25-rc9, but I can pull the Xilinx tree or
>>  yours - when your server is up.
>>
>>     I can not find any Xilinx powerpc configs in arch/powerpc/config
>>     Do I just need to do a
>>     make ARCH=powerpc menuconfig and create one from scratch ?
>>     
>
> That's right; I haven't merged any defconfigs.  Roll your own.
>
>   
>>     Is simpleboot in your tree or the xilinx tree, if  can not find it
>>  in Linus's ?
>>     
>
> If you want to use the "simpleboot" wrapper; then you'll need to pull
> paulus' tree (Linus hasn't yet pulled his tree; but he probably will
> any moment now).
>
> Cheers,
> g.
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
