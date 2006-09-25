Return-Path: <ammubhai@gmail.com>
Received: from marmot.shef.ac.uk (marmot.shef.ac.uk [143.167.1.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFF2467A2E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Sep 2006 19:48:48 +1000 (EST)
Message-ID: <45179FF7.3000400@gmail.com>
Date: Mon, 25 Sep 2006 10:23:03 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: agnel juni <junijoseph@yahoo.co.in>
Subject: Re: linux-2.6 system ACE driver - need help
References: <20060919224349.25812.qmail@web8408.mail.in.yahoo.com>
In-Reply-To: <20060919224349.25812.qmail@web8408.mail.in.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

agnel juni wrote:
> Hi Ameet
>
> I have posted a few messages regarding Ssytem ACE driver for Linux-2.6.
>
> We are working on a AMCC 440SPe based custom board.
>
> We applied the patch from
> //http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch
>  //and applied against 2.6.16-2 kernel.
>
> We are trying to make the driver work in interrupt mode.
>
> First, I would like to know if the driver tested in interrupt mode.
>
> We are able to mount the CF, but it is very inconsistent.
>
> Same is the case with fdisk command. When it fails,we get errors which you could see in the screen-dump below.//
> //
> Are we missing to apply the right patch? Please let us know your 
> inputs to go forward.
> Looking forwards for your reply.
>
> Thanks
> Junita
>
> /*************** Screen dump ********************/
> # fdisk /dev/xsysace
> 1. sector = 0 xsa_cur_req->sector=0
> System ACE: Error 0 when reading sector 2.
> 2. sector = 2 xsa_cur_req->sector=16
> end_request: I/O error, System ACE: Error 0 when reading sectoru dev 
> xsa, sector 16
> Buffer I/O error on device xsa, logical block 2
> 1. sector = 184 xsa_cur_req->sector=184
>  
> Command (m for help): p
>  
> Disk /dev/xsysace: 524 MB, 524869632 bytes
> 17 heads, 59 sectors/track, 1022 cylinders
> Units = cylinders of 1003 * 512 = 513536 bytes
>  
>        Device Boot      Start         End      Blocks   Id  System
> /dev/xsysace1               1        1022      512503+   6  FAT16
>  
> Command (m for help): q
> And for 'mount'
> #
> #
> # mount -t msdos /dev/xsysace /root/cf
> 1. sector = 0 xsa_cur_req->sector=0
> 1. sector = 503 xsa_cur_req->sector=503
> 1. sector = 504 xsa_cur_req->sector=504
> 1. sector = 506 xsa_cur_req->sector=506
> 1. sector = 508 xsa_cur_req->sector=508
> 1. sector = 510 xsa_cur_req->sector=510
> # cd /root/cf
> < Here Prints Some Symbols like + - etc, which i am
>   not able to capture/copy -------------ERROR
> b: No such file or directory--------------------------------ERROR
> pci.h
> #
> Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.n0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.d#
> # cp pci.h /root/
> # cd ../
> # ls
> app     cf      hello1  pci.h
> #
> #/root
>  /dev/xsysace /root/cf
> FAT: bogus number of reserved sectors
> VFS: Can't find a valid FAT filesystem on dev xsa.
> mount: Mounting /dev/xsysace on /root/cf failed: Invalid argument
> #
>  
>
>
> //
>
>
>
> //
>
> ------------------------------------------------------------------------
> Find out what India is talking about on - Yahoo! Answers India 
> <http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/>
> Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. 
> Get it NOW 
> <http://us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com> 


Hi Agnel,
    The driver was last tested with 2.6.17 kernel and till date works 
fine in the interrupt mode. I have been using it since the last 4 months 
now. It should also work on 2.6.16-2 kernel I think, but I have not 
tested this. Have you made any changes to the driver? If so... please 
give the details so I can give you better feedback as to where things 
might have gone wrong. When time permits I shall try my patch on the 
2.6.16-2 kernel and let you know if it works for me.

Thanks,
-Ameet
