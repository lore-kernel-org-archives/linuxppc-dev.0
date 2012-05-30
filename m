Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 8289CB702A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2012 20:57:20 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 24082-06 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 30 May 2012 11:57:10 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: pread() and pwrite() system calls
Date: Wed, 30 May 2012 11:56:21 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6F32@saturn3.aculab.com>
In-reply-to: <20120525164550.GA32406@visitor2.iram.es>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Gabriel Paubert" <paubert@iram.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > We have a system with linux 2.6.32 and the somewhat archaic
> > uClibc 0.9.27 (but I'm not sure the current version is
> > any better, and I think there are binary compatibility
> > if we update).
> >=20
> > I've just discovered that pread() is 'implemented'
> > by using 3 lseek() system calls and read().
> > (the same is true for the 64bit versions).
...
> I think that it is an uClibc problem.

It seems that uClibc hadn't been changed when the
names of the constants used for the system calls
were changed from __NR_pread to __NR_pread64.

	David
