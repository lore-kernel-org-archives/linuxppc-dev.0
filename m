Date: Thu, 18 Sep 2003 20:26:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BOOT_TARGET pImage & uImage ???
Message-ID: <20030918182654.GA1444@mars.ravnborg.org>
References: <3F65917D.1020502@imc-berlin.de> <20030915150935.GB29517@ip68-0-152-218.tc.ph.cox.net> <3F699255.4050000@imc-berlin.de> <20030918180834.GC6692@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030918180834.GC6692@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> What I want is three things:
> 1) The 'mkimage' target must be done in such a fashion that it will
> never run into a 'cannot execute' problem.  My suggestion is to have the
> Makefile do a:
> @chmod +x mkimage.sh
> Or so.  In 2.5/2.6, the build system will handle this for you,
> automagically, on .sh files I believe.  For 2.4, you must handle this
> explicitly.

In 2.6 you need to locate the script in scripts/ and add it to the
makefile to make this happen. Do not do that.

Best way IMO is to use:
$(CONFIG_SHELL) mkimage.sh

This works in both 2.4 and 2.6.

> 2) Do we really need 'pImage' and 'uImage' or can we just have 'uImage'

Please kill pImage. PPCBOOT is dead, we shall focus on "Das U-boot".

	Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
