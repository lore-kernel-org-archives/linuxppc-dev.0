Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 7452267A6D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Mar 2005 04:35:42 +1100 (EST)
Message-ID: <423B1164.9020805@mvista.com>
Date: Fri, 18 Mar 2005 10:35:32 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: srinivas.surabhi@wipro.com
References: <EF9B29C78F41FA488927FCBC7750AF0E011DA9A5@hyd-mdp-msg.wipro.com>
In-Reply-To: <EF9B29C78F41FA488927FCBC7750AF0E011DA9A5@hyd-mdp-msg.wipro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PCI problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

srinivas.surabhi@wipro.com wrote:

>Hi,
>
>We are facing the problem with MVlinux3.1 having kernel 2.4.20 booting
>once the PCI is enabled in config kernel.
>
>First Question is it any where required in linux kernel sources to make
>the PCI configuration changes...IF so please let me know in which file
>??
>
>Even the message "linux kernel banner " which is at the beginning of the
>start_kernel function is not seen. Once the multi image( kernel + ram
>disk File system) is extracted into RAM. After that it hangs
>
>
>bootm 0xfef80000 ## Booting image at fef80000 ...
>   Image Name:   MultiImage
>   Image Type:   PowerPC Linux Multi-File Image (gzip compressed)
>   Data Size:    4647626 Bytes =  4.4 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Contents:
>   Image 0:   551181 Bytes = 538.3 kB
>   Image 1:  4096430 Bytes =  3.9 MB
>   Verifying Checksum ... OK
>   Uncompressing Multi-File Image ... =0=
>OK
>Booting Linux
>   Loading Ramdisk to 07417000, end 077ff1ae ... OK
>
>...Then hangs ....
>
>SO please help me out in finding out the relation of PCI and the
>start_kernel. As per my knowledge once the kernel_init is entered then
>the pci_init is invoked. But strangely I am seeing with pci enabled,
>hang at the very beginning..
>
>Thanks & Rgds
>SS
>
>-----Original Message-----
>From: wd@denx.de [mailto:wd@denx.de]
>
>Sent: Thursday, February 17, 2005 5:13 PM
>To: Srinivas Surabhi (WT01 - EMBEDDED & PRODUCT ENGINEERING SOLUTIONS)
>Cc: linuxppc-embedded@ozlabs.org
>Subject: Re: Mounta Vista Linux prompt on serial console
>
>
>In message
><EF9B29C78F41FA488927FCBC7750AF0E08DA14@hyd-mdp-msg.wipro.com> you
>wrote:
>  
>
>
>  
>
>>But the problem is that it was stopping at
>>
>>    
>>
>
>  
>
>>"No init found.  Try passing init= option to kernel". Before that
>>    
>>
>there
>  
>
>> were no errors. Everthing looks fine Mounted VFS root file system was
>>    
>>
>also
>
>Fine. So you can mount the root filesystem, but it obviously does not
>contain all the required files.
>
>  
>
>> seen. From the net I understood is that the fstab file was the cause.
>>    
>>
>So
>  
>
>> edited the filesytem parameter for / as /dev/ram earlier it used to
>>    
>>
>be
>  
>
>> /dev/root.
>>    
>>
>
>No. /etc/fstab has absolutley nothing to do with  your  problem.  The
>kernel  cannot  start  the  init  porocess - make sure init is in the
>filesystem, plus all required libraries.
>
>  
>
>>So please tell me whether the given fstab file will suffice? The
>>    
>>
>filesystem
>
>This is completley unrelated.
>
>  
>
>>2. I have one more doubt /sbin/init utility comes with what package?
>> Because in /sbin directory although the init binary is present, not
>>    
>>
>shown
>  
>
>> in the file system heirarchy view. For eg. if I select DHCPD package
>>    
>>
>then
>  
>
>> able to see dhcpd related binary in the /sbin similarly my question
>>    
>>
>was
>  
>
>> which package has to be selected to have init included.
>>    
>>
>
>Please contact MV support. I have no  idea  how  they  package  their
>distribution,  or  how  their  config  tools might work. You paid for
>their stuff, so ask _them_.
>
>Best regards,
>
>Wolfgang Denk
>

Srinivas,

1) Please don't post the same question twice to the same mailing list.

2) Please stop replying to a msg in an existing thread when you start a 
new thread.  Go look at 
http://ozlabs.org/pipermail/linuxppc-embedded/2005-March/thread.html.  
Your new thread appear as though its part of 440GX 2.6 NAP thread.  It 
looks like you've done that in other threads too.

3) When you ask a question, please provide enough detail so that there 
is at least the possibility that someone else can help you.  What 
platform is this on?  Did this kernel ever work for you on that 
platform?  If so, then what have you changed?

4) Heed Wolfgang's advice...if you actually did pay MontaVista for 
support then you should be contacting them.

Mark
