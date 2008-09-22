Return-Path: <jacmet@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id E7E9CDDED4
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 16:28:28 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1390394fga.39
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Sep 2008 23:28:26 -0700 (PDT)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: gpio driver for mpc8349/8572/8610 and
	compatible
References: <1222026361-28133-1-git-send-email-jacmet@sunsite.dk>
	<99055FC9-255A-4ECF-863B-3CDB6589ED9E@kernel.crashing.org>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 22 Sep 2008 08:28:23 +0200
In-Reply-To: <99055FC9-255A-4ECF-863B-3CDB6589ED9E@kernel.crashing.org> (Kumar
	Gala's message of "Sun\, 21 Sep 2008 20\:38\:58 -0500")
Message-ID: <87abe0y9rs.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Kumar" == Kumar Gala <galak@kernel.crashing.org> writes:

 Kumar> On Sep 21, 2008, at 2:46 PM, Peter Korsgaard wrote:

 >> +GPIO controllers on MPC8xxx SoCs
 >> +
 >> +Every GPIO controller node must have #gpio-cells property defined,
 >> +this information will be used to translate gpio-specifiers.
 >> +

 Kumar> Can we add a comment about this being the non-QE/CPM/GUTs GPIO
 Kumar> support.  And maybe a reference to the 8349 as an example of the
 Kumar> controller if unsure about the compatibility.

Sure.

 Kumar> Also, does it make sense to have a reference to the top-level generic
 Kumar> GPIO info w/regards to pin specific info, etc..

Ok, I'll add that and resend.

-- 
Bye, Peter Korsgaard
