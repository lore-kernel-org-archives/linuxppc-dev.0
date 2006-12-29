Return-Path: <Wei.Zhang@freescale.com>
Message-ID: <45947BA7.7000704@freescale.com>
Date: Fri, 29 Dec 2006 10:21:27 +0800
From: Zhang Wei <wei.zhang@freescale.com>
MIME-Version: 1.0
To: "Morrison, Tom" <tmorrison@empirix.com>
Subject: Re: MPC8548 PCI Express Support
References: <BD261180E6D35F4D9D32F3E44FD3D90105CF46AB@EMPBEDEX.empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D90105CF46AB@EMPBEDEX.empirix.com>
Content-Type: text/plain; charset=GB18030; format=flowed
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes, the MPC8548 patch for 2.6.18 is under development, please wait for 
a while.

Morrison, Tom wrote:
> Hi,
>
> I am a newbie to this list. I have tried to search the 
> list's archives to see if this has been discussed 
> for ideas, and I do not see anything related to this.
>
> I am working on a MPC8548 platform, which has a 
> PLX 8532 PCI-Express chip on it. 
>
> I am using a 2.6.18.x linux kernel (x=6 at the moment)
>
> I saw there are patches for linux kernel for 2.6.11.x 
> (via freescale), but I am hoping you guys know of something
> a little 'newer' than that (so I can patch a 2.6.18.6 kernel)
>
> Also,l PLX supplies a linux driver, but it is module driven. 
> I could put the module and associated 'loader' into the InitRD image 
> (and load it up), but it would be 'neater' to have the support
> built-in to the kernel. Would you guys have any suggestions 
> and/or experience with this?
>
> Any/all suggestions and experiences shared are more than welcomed. 
>
> All the best~!
>
> Tom Morrison
> tmorrison@empirix.com 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>   
