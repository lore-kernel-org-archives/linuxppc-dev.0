Return-Path: <emrekara2002@yahoo.co.uk>
Received: from web25902.mail.ukl.yahoo.com (web25902.mail.ukl.yahoo.com
	[217.12.10.200]) by ozlabs.org (Postfix) with SMTP id C42A06856F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Oct 2005 16:13:29 +1000 (EST)
Message-ID: <20051014060647.43845.qmail@web25902.mail.ukl.yahoo.com>
Date: Fri, 14 Oct 2005 07:06:47 +0100 (BST)
From: emre kara <emrekara2002@yahoo.co.uk>
To: gaashpub-lnx@yahoo.com, linuxppc-embedded@ozlabs.org
In-Reply-To: <20051013170932.88571.qmail@web32512.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: gaashpub-lnx@yahoo.com
Subject: Re: network driver over shared memory
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

There is a dethernet(pci slave)/methernet(pci master)
driver in metrowerks eval8540 bps, this driver
provides ethernet interface that can communicate over
PCI bus. It's specific to 85xx family but may be can
help you.
follow this link:
http://www.metrowerks.com/MW/Develop/Embedded/Linux/DownloadBSP.htm
Emre
--- gaashpub-lnx@yahoo.com wrote:

> Experts,
> 
> Hope this is not a too dumb question.
> 
> I have an embedded system with a few PPCs, one
> master
> and a few slaves. All PPCs are interconnected with
> shared memory over PCI.
> 
> I would like to create and IP or "Ethernet like"
> network between all the PPCs to enable files
> transfer 
> over FTP or NFS between the master and the slaves.
> 
> Is there a network driver for this in 2.6 kernel. If
> not any idea where to look for or with what to begin
> with.
> 
> PS: Please put my email in the reply as I'm not
> member
> of this list (yet)
> 
> Thanks
> 
> Gaash
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 



		
___________________________________________________________ 
How much free photo storage do you get? Store your holiday 
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com
