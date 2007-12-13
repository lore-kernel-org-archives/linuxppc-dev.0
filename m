Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (uncle.computing.dundee.ac.uk
	[134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6AB1DE0BA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Dec 2007 00:41:38 +1100 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	lBDDSieE017570
	for <linuxppc-embedded@ozlabs.org>; Thu, 13 Dec 2007 13:28:44 GMT
Message-ID: <4761338B.2040000@computing.dundee.ac.uk>
Date: Thu, 13 Dec 2007 13:28:43 +0000
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: vinay kumar <vinay453.techie@gmail.com>
Subject: Re: How to Build Rootfile system
References: <e8e184520712122203s12b9742ckbee6b1afbee7d50f@mail.gmail.com>
In-Reply-To: <e8e184520712122203s12b9742ckbee6b1afbee7d50f@mail.gmail.com>
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

Hi Vinay,
I use buildroot (http://buildroot.uclibc.org/) for my root filing system 
and it's been easy.  I even use the toolchain it generates to compile my 
kernels with.  Before that I was using crosstool 
(http://www.kegel.com/crosstool/) to give me a cross-compiler and I 
created a busybox (http://www.busybox.net/) rootfs the hard way.
Regards,
-- Peter
> Hi All,
>
> I have booted linux on PPC440GP with treeimage(zimage+initrd).
> Now my next aim is to have a more stable rootfile system.
>
> I wanted to know the procedure of building a root file system for 
> PPC440GP architecture.
>
> Pls share your knowledge and also some links.
>
>
> regards to all,
> vinay
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
MailScanner thanks transtec Computers for their support.
