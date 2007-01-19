Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id BD722DDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 10:20:05 +1100 (EST)
In-Reply-To: <000501c73c1e$e6957b30$6405a8c0@absolut>
References: <000501c73c1e$e6957b30$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9268E062-17E2-4E23-B234-7F58E1F758FF@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: DTC compilations 
Date: Fri, 19 Jan 2007 17:20:00 -0600
To: "Russell McGuire" <rmcguire@uwbt.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 19, 2007, at 17:09, Russell McGuire wrote:

> All,
>
>
>
> Thanks for those who helped me past ARCH-ppc stuff, kernel compiles  
> fine now.
>
>
>
> Next question, I am using the latest<pretty sure> DTC from jdl.com  
> to compile up a sample .dts file.
>
> I noted that all the .dts files in the /arch/powerpc/boot/dts do  
> not contain a /chosen node. So if I compile any of them, I get an  
> error and no resulting blob file.
>
>
>
> Do I have the wrong version of the DTC? Or is this a new feature  
> that I need to implement add to the .dts file I create?

Current versions "require" the chosen node.  u-boot will provide it,  
though, so you don't need to add it unless your u-boot doesn't  
provide it (This would mean you'd need to boot with a boot wrapper.   
Or get a newer u-boot ;) ).  In order to avoid the error being fatal,  
pass "-f" to the dtc.  I believe it's on the communal "TODO" list for  
the dtc.  But, given the choice between modifying the code, and  
adding "-f" to the command line, most people have chosen the two- 
character option.

Andy
