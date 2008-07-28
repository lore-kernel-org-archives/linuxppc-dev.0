Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id 2F528DE410
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 04:02:45 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so5923400wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 11:02:44 -0700 (PDT)
Date: Mon, 28 Jul 2008 12:02:41 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: "Sparks, Sam" <SSparks@aclaratech.com>
Subject: Re: mpc8349-mITX DTB load failure
Message-ID: <20080728180241.GD21534@secretlab.ca>
References: <6011A7C9CD0EE74792C3ED2A8355608634213E@mail.twacs.com>
	<20080728171634.GB21265@secretlab.ca>
	<6011A7C9CD0EE74792C3ED2A8355608634214C@mail.twacs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6011A7C9CD0EE74792C3ED2A8355608634214C@mail.twacs.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 28, 2008 at 12:49:19PM -0500, Sparks, Sam wrote:
> No luck there, either. I ran into a issue with space a year ago, and was
> getting the FDT_ERR_NOSPACE error until I added the -S 0x3000 option.
> This looks like something completely different.

Does your dts source file already have a chosen node?  There had been an
issue where u-boot cacks if chosen was pre-created.

g.
