Return-Path: <rmcguire@uwbt.com>
Received: from mail19d.g19.rapidsite.net (mail19d.dulles19-verio.com
	[204.202.242.120]) by ozlabs.org (Postfix) with SMTP id 445AD6828C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Sep 2005 09:19:25 +1000 (EST)
Received: from mx04.stngva01.us.mxservers.net (204.202.242.98)
	by mail19d.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id
	2-0525395962 for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Sep 2005 19:12:43 -0400 (EDT)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 15 Sep 2005 16:12:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <20050915191243.GA52539@mail19d.g19.rapidsite.net>
Subject: Getting Perl on Embedded Linux PowerPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Anyone,

I was attempting to get some ATM Tools compiled into the embedded PowerPC,
and found I needed Perl installed on the target before I continue.

So my question...

Has anyone had any luck getting any version of Perl 5 or higher installed
onto the file system. I am still running this over the NFS dev environment,
and plan to remove it before final production, so space is of no concern at
the moment.  

Or perhaps a pre-compiled RPM that installs, that is built for PowerPC.

I am using DENX Linux 2.4.25 at the moment, with pretty much the default
root file system that is provided.

-Russ
