Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1FC6867BD9
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Sep 2006 07:39:28 +1000 (EST)
Date: Mon, 4 Sep 2006 23:39:25 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Reddy Suneel-ASR125 <suneel.reddy@motorola.com>
Subject: Re: booting Linux in Linux using kexec tools
In-Reply-To: <405ECA8A30557F439A723E52D50838F9D829C6@ZMY16EXM66.ds.mot.com>
Message-ID: <Pine.LNX.4.60.0609042336020.5921@poirot.grange>
References: <405ECA8A30557F439A723E52D50838F9D829C6@ZMY16EXM66.ds.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Hi Suneel

On Wed, 30 Aug 2006, Reddy Suneel-ASR125 wrote:

> I am trying to boot Linux (zImage.elf) in Linux using kexec tools. 
>  
> I am getting the folling crash
>  
> sh-2.05b#
> sh-2.05b# kexec -e
> Shutting down gianfar ethernet
> Shutting down gianfar ethernet
> Shutting down gianfar ethernet
> Starting new kernel
> Bye!
> Oops: kernel access of bad area, sig: 11 [#1]

Have you got it working? Where do your kexec tools come from? Are they 
based on a version from http://www.xmission.com/~ebiederm/files/kexec/ 
and, if yes, how did yo adjust it to your system?

Thanks
Guennadi
---
Guennadi Liakhovetski
