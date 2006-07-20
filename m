Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 07D0167BAC
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 22:31:48 +1000 (EST)
From: "Matt Sealey" <matt@genesi-usa.com>
To: "'Linas Vepstas'" <linas@austin.ibm.com>,
	"'Paul Mackerras'" <paulus@samba.org>
Subject: RE: AltiVec in the kernel
Date: Thu, 20 Jul 2006 07:31:32 -0500
Message-ID: <001301c6abf8$73d780e0$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20060719181047.GL5905@austin.ibm.com>
Cc: 'linuxppc-dev list' <linuxppc-dev@ozlabs.org>
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> But perhaps, in principle, couldn't one run four independent 
> streams in parallel?  Thus, for example, on an SSL-enabled 
> web server, one could service multiple encryption/decryption 
> threads at once. 
> 
> In practice, I don't beleive the infrastructure for that kind 
> of parallelism is in place. I'm struggling to find a reason 
> to develop that kind of infrastructure. Mumble something about Cell. 

If not AltiVec there is potential to use some features which come
with AltiVec like the data stream functionality. Or even the standard
PPC cache control stuff would work.

What's the case in the kernel for the memcpy functions etc., are
they optimized for doing things like longword copies rather than
byte-per-byte etc.? We found glibc sucked for that.

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
