Return-Path: <baringforge@gmail.com>
Received: from mail-fx0-f44.google.com (mail-fx0-f44.google.com
	[209.85.161.44]) by ozlabs.org (Postfix) with ESMTP id 765D61007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Dec 2010 18:30:03 +1100 (EST)
Received: by fxm9 with SMTP id 9so1804418fxm.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Dec 2010 23:30:00 -0800 (PST)
MIME-Version: 1.0
Sender: baringforge@gmail.com
From: Thomas Taranowski <tom@baringforge.com>
Date: Tue, 14 Dec 2010 23:29:38 -0800
Message-ID: <AANLkTinwP6kQvWjSO3cxNUqd7tx7dhGEShTdKQXj-+iD@mail.gmail.com>
Subject: RapidIO: multiple mport support for QorIQ
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm planning to add support for the multiple(2) mports supported by
the Freescale p2020 processor.  I'm currently looking at the fsl layer
to add in support for multiple port enumeration, and work up from
there.  It looks like the upper layers already have at least partial
support for this.  My question is, are there any efforts already
ongoing I can hop in on so as not to duplicate effort?  If not, I'll
just do it.

There is some divergance in respect to the memory map that is
non-trivial that I'm not sure how to handle, since it totally hoses
the common fsl_rio.c structures.  I think I want to create a new set
that's p2020 specific, but has potential to be shared with the other
QorIQ series, so dumping the pseries-specific code into
platforms/pseries seems like a reasonable way to go.  Thoughts?

Thanks!


Thomas Taranowski
Certified netburner consultant
baringforge.com
