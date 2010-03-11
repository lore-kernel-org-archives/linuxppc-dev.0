Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D37FDB7DE3
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 08:45:38 +1100 (EST)
Subject: Re: madness, was Re: [PATCH 2/2] Macintosh: fix coding style
	issues in adb.c This is a patch to the adb.c file that cleans up many
	warnings found by the checkpatch.pl tool
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: fthain@telegraphics.com.au
In-Reply-To: <alpine.LNX.2.00.1003101428460.4583@nippy.intranet>
References: <1268172438-76422-1-git-send-email-mbeards2@uoregon.edu>
	<alpine.LNX.2.00.1003101428460.4583@nippy.intranet>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Mar 2010 08:45:10 +1100
Message-ID: <1268343910.22204.710.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Beardsworth <mbeards2@uoregon.edu>, monstr@monstr.eu,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	geert@linux-m68k.org, Nick Savage <nagaten@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-03-10 at 14:48 +1100, fthain@telegraphics.com.au wrote:
> On Tue, 9 Mar 2010, Michael Beardsworth wrote:
> 
> > -	/* If a probe is in progress or we are sleeping, wait for it to complete */
> > +	/* If a probe is in progress or we are sleeping, wait until complete */
> 
> If you must "fix" what aint broke, please try not to damage it. I'm sorry 
> if your VT52 is limited to 80 cols, but IMNSHO this sort of effort is 
> misguided.
> 
> Maybe I could point out again (I do this periodically) that checkpatch.pl 
> is great but code that fails it is NOT always wrong.
> 
> "Check patch" is a good idea but "check existing code" is a waste of 
> everyone's time.

Amen !

Cheers,
Ben.
