Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 91869DDF1B
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 11:15:22 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1409460anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 16:15:20 -0800 (PST)
Message-ID: <fa686aa40802121615v72db8ce4l122d43dccb2b8e96@mail.gmail.com>
Date: Tue, 12 Feb 2008 17:15:20 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Could the DTS experts look at this?
In-Reply-To: <47B2300B.4060101@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47ACE630.8090101@pikatech.com>
	<20080211235409.GB18348@localhost.localdomain>
	<20080211235652.GC18348@localhost.localdomain>
	<200802120121.45349.arnd@arndb.de> <47B1BEE7.4050808@freescale.com>
	<fa686aa40802121058u6c6e4ba9s3ced2e35950745ea@mail.gmail.com>
	<47B1EEA8.4040904@freescale.com>
	<20080212232639.GD21230@localhost.localdomain>
	<47B2300B.4060101@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 12, 2008 4:47 PM, Timur Tabi <timur@freescale.com> wrote:
> David Gibson wrote:
>
> > I can pretty much guarantee you that someone will find that
> > insufficient and want to expand the conditional representation.  This
> > way madness lies.
>
> Then let them.  We can have version numbers associated with the conditional
> expressions.  If they want to make more complex condition expressions, they can
> bump the version number and define a spec and write code to parse it.

You say that as if bumping the version number is cheap to do.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
