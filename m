Return-Path: <wolfgang@leila.ping.de>
Received: from lilly.ping.de (lilly.ping.de [83.97.42.2])
	by ozlabs.org (Postfix) with SMTP id 36AE8DE071
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 10:22:11 +1100 (EST)
Date: Thu, 27 Mar 2008 00:18:42 +0100
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Which Kernel for Ocotea (440GX)?
Message-ID: <20080326231842.GI15725@leila.ping.de>
References: <20080325220742.GD15725@leila.ping.de>
	<20080325224533.97BF3243A7@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080325224533.97BF3243A7@gemini.denx.de>
From: wolfgang@leila.ping.de (Wolfgang Wegner)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Wolfgang,

On Tue, Mar 25, 2008 at 11:45:33PM +0100, Wolfgang Denk wrote:
> 
> You can find Ocotea support (still arch/ppc only) in our kenrel
> repository - see git://www.denx.de/git/linux-2.6-denx.git
> 
> I think if you just followed the links on AMCC's web site they should
> have taken you there, too. Please let me know if this didn't work for
> some reason.

thank you very much, I fetched the kernel and at least it built
correctly.

It seems I am still doing something wrong with configuration, but as
I am getting this far, it should be possible to solve. I just wanted
to give feedback in time that the build is OK.

Thank you and best regards,
Wolfgang

At the moment this is what I get:

=> bootm 0x400000                                                               
## Booting image at 00400000 ...                                                
   Image Name:   Linux                                                          
   Created:      2008-03-26  23:12:26 UTC                                       
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)                   
   Data Size:    1428044 Bytes =  1.4 MB                                        
   Load Address: 00000000                                                       
   Entry Point:  00000000                                                       
   Verifying Checksum ... OK                                                    
   Uncompressing Kernel Image ... OK                                            
id mach(): done                                                                 
MMU:enter                                                                       
MMU:hw init                                                                     
MMU:mapin                                                                       
MMU:setio                                                                       
MMU:exit                                                                        
setup_arch: enter                                                               
setup_arch: bootmem                                                             
ocp: exit                                                                       
arch: exit                                                                      
