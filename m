Return-Path: <chrispl78@yahoo.com>
Received: from web58104.mail.re3.yahoo.com (web58104.mail.re3.yahoo.com
	[68.142.236.127]) by ozlabs.org (Postfix) with SMTP id 7499CDDE0D
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 08:12:08 +1000 (EST)
Message-ID: <475052.53669.qm@web58104.mail.re3.yahoo.com>
Date: Thu, 7 May 2009 15:12:07 -0700 (PDT)
From: Chris Plasun <chrispl78@yahoo.com>
Subject: Trouble using with Kegel cross tool chain
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > + echo 'SRC_DIR not set, so source tarballs will be unpacked in the 
> > build dir
> > ectory'
> > SRC_DIR not set, so source tarballs will be unpacked in the build 
> > directory
> > + case x$PREFIX in
> > + case x$USER in
> > + abort 'Don'\''t run all.sh or crosstool.sh as root, it'\''s
> > dangerous'
> > + echo 'Don'\''t' run all.sh or crosstool.sh as root, 'it'\''s' 
> > dangerous
> > Don't run all.sh or crosstool.sh as root, it's dangerous
> > + exec false
> 
> Are you running as root?  If so, don't.
> 
> Mikey

Ah, now it's doing something...

Thanks Mikey. I didn't think running as root would prevent the process from running. Everything is running in VirtualBox so I wasn't concerned about blowing things up.

The build has been in progress for the past 15 minutes...

I set the target as powerpc-603. Is this appropriate for the MPC8313?

Thank you.

Chris Plasun
