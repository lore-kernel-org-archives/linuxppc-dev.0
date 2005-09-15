Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 260376829F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Sep 2005 09:42:58 +1000 (EST)
To: "Russell McGuire" <rmcguire@uwbt.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 15 Sep 2005 16:12:42 PDT."
	<20050915191243.GA52539@mail19d.g19.rapidsite.net>
Date: Fri, 16 Sep 2005 01:42:39 +0200
Sender: wd@denx.de
Message-Id: <20050915234239.75CC6353B46@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Getting Perl on Embedded Linux PowerPC 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050915191243.GA52539@mail19d.g19.rapidsite.net> you wrote:
> 
> I was attempting to get some ATM Tools compiled into the embedded PowerPC,
> and found I needed Perl installed on the target before I continue.

You probably want to avoid his in an embedded system...

> Has anyone had any luck getting any version of Perl 5 or higher installed
> onto the file system. I am still running this over the NFS dev environment,
> and plan to remove it before final production, so space is of no concern at
> the moment.  

Sure. This is trivial. Perl configures and builds just fine, assuming
you have enough time, memory and swap space.

> Or perhaps a pre-compiled RPM that installs, that is built for PowerPC.

No RPM, sorry.

> I am using DENX Linux 2.4.25 at the moment, with pretty much the default
> root file system that is provided.

Just follow the standard instructions for  configuring  and  building
Perl  (in  native  mode, of course). I did this several times before,
without any problems. You have to be patient,  though,  It's  a  huge
amount of code, and definitely takes a lot of time to compile.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Never underestimate the bandwidth of a station wagon full of tapes.
                                -- Dr. Warren Jackson, Director, UTCS
