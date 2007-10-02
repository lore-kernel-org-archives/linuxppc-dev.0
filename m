Return-Path: <jacmet@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by ozlabs.org (Postfix) with ESMTP id 24FF1DDF73
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 02:02:06 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so4686544fkz
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 09:02:05 -0700 (PDT)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 11/18] Virtex: Port UARTLITE driver to of-platform-bus
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181748.18608.62409.stgit@trillian.cg.shawcable.net>
	<87641p34dn.fsf@macbook.be.48ers.dk>
	<fa686aa40710020856x5faf2d82p281bb269286ba4c4@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 02 Oct 2007 18:01:57 +0200
In-Reply-To: <fa686aa40710020856x5faf2d82p281bb269286ba4c4@mail.gmail.com>
	(Grant Likely's message of "Tue\, 2 Oct 2007 09\:56\:28 -0600")
Message-ID: <87tzp91p56.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 Grant> On 10/2/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
 >> >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
 Grant> +       pr_debug("uartlite: calling platform_driver_register()\n");
 Grant> +       if ((ret = platform_driver_register(&ulite_platform_driver)) != 0)
 >> 
 >> I prefer to not have assignments in the if ().

 Grant> Already fixed in v3

Ok, thanks.

 >> Are all the pr_debug necessary? It looks quite messy.

 Grant> Maybe messy, but *very* useful.  Looks prettier in the v3 version with
 Grant> the assignment and if() on separate lines.

Ok, I'll take a look (sorry, I'm behind on mails..)

-- 
Bye, Peter Korsgaard
