Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 53F6067C1E
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 07:02:01 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB6K1krc004328
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 15:01:46 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB6K1kbO199128
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 15:01:46 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB6K1kCu024598
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 15:01:46 -0500
Date: Wed, 6 Dec 2006 14:01:45 -0600
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: Bug report: CELL on linux-2.6.19-git7 won't build,
Message-ID: <20061206200143.GE17931@austin.ibm.com>
References: <20061206192745.GC17931@austin.ibm.com>
	<45771DC3.8000505@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45771DC3.8000505@am.sony.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 06, 2006 at 11:45:07AM -0800, Geoff Levand wrote:
> Linas,
> 
> Yes, that's with CONFIG_HEADERS_CHECK=y.  

I have to turn that off. Its annoying, actually.

> Arnd sent that fix
> out yesterday.  Please see:

Ahh! Indeed, ...  skimmed my email too fast.
Thanks!

--linas
