Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (unknown [151.38.134.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 374D0DDF3C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 22:59:25 +1000 (EST)
Date: Wed, 23 Jul 2008 14:47:45 +0200
From: Alessandro Rubini <rubini@gnudd.com>
To: misbah_khan@engineer.com
Subject: Re: how to allocate 9MB of memory in kernel ?
Message-ID: <20080723124745.GA20156@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@gnudd.com
In-Reply-To: <18605418.post@talk.nabble.com>
References: <18605418.post@talk.nabble.com> <18503022.post@talk.nabble.com>
	<200807170956.52101.arnd@arndb.de>
	<18522535.post@talk.nabble.com> <48803D3C.5020608@coritel.it>
	<18525063.post@talk.nabble.com> <200807181739.10268.arnd@arndb.de>
	<18582612.post@talk.nabble.com> <200807221131.32556.arnd@arndb.de>
	<4885AC94.7050501@coritel.it> <18587466.post@talk.nabble.com>
	<200807221712.52030.arnd@arndb.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> If i allocate 9BM using vmalloc and remap to user space how should it
> address to the 9MB 
> SDRAM contigues address which i need to map for user access ? 

Use the nopage method and vmalloc_to_page in it.

I have an example in ftp://gnudd.com/pub/samplecode, in the
smallsample26 package, the module is "smallmmap.c" (I'm sure there are
simlilar examples elsewhere).

/alessandro
