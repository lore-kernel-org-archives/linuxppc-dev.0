Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 18 Sep 2003 21:38:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BOOT_TARGET pImage & uImage ???
Message-ID: <20030918193835.GA2320@mars.ravnborg.org>
References: <3F65917D.1020502@imc-berlin.de> <20030915150935.GB29517@ip68-0-152-218.tc.ph.cox.net> <3F699255.4050000@imc-berlin.de> <20030918180834.GC6692@ip68-0-152-218.tc.ph.cox.net> <20030918182654.GA1444@mars.ravnborg.org> <20030918183357.GG6692@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030918183357.GG6692@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 18, 2003 at 11:33:57AM -0700, Tom Rini wrote:
> >
> > In 2.6 you need to locate the script in scripts/ and add it to the
> > makefile to make this happen. Do not do that.
>
> There's an arguement for putting this in scripts/, and that is that
> U-BOOT is not a PPC-specific bootrom anymore, as it looks like you well
> know. :)

You got me wrong (read: I did not express it clear).
What I do not wani't is to use scripts/Makefile to set the exucutable
bit. I'm perfectly fine with having the script in scripts/.

Actually thats the only suitable place, since it will be used by ARM
as well (I assume).

	Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
