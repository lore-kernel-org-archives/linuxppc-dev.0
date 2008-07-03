Return-Path: <dzu@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DFAA9DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 02:26:08 +1000 (EST)
From: Detlev Zundel <dzu@denx.de>
To: Dave Cogley <dcogley@uslinc.com>
Subject: Re: Updating glibc on SELF image
References: <1213824912.4450.20.camel@localhost.localdomain>
	<1213901149.4450.22.camel@localhost.localdomain>
	<m2hcb82ld1.fsf@ohwell.denx.de>
	<1215026295.3492.15.camel@localhost.localdomain>
Date: Thu, 03 Jul 2008 18:24:40 +0200
In-Reply-To: <1215026295.3492.15.camel@localhost.localdomain> (Dave Cogley's
	message of "Wed, 02 Jul 2008 12:18:15 -0700")
Message-ID: <m23amrylyv.fsf@ohwell.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi Dave,

> Thank you for the reply. I did not build the initial SELF image it was
> provided to me from the board vendor. I used it as a starting point to
> get something up and running on SELF. Can you point me to the
> documentation on how to use the SELF RPM system?

Rebuilding the SELF image boils down to rebuilding the SELF "target
package" having nothing SELF specific in the process.  This is explained
in the DULG[1].

Cheers
  Detlev

[1] http://www.denx.de/wiki/view/DULG/ELDKRebuildingComponents#Section_3.7.2.

-- 
... that every year or so they're going to give you a new release full
of 50 000  additional lines of code all  written  by monkeys.  Because
they generally follow  the  ``million monkeys typing,   and eventually
they'll come up with something useful'' school of system development.
	                                    -- Richard M. Stallman
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
