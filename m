Date: Thu, 18 Sep 2003 11:33:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BOOT_TARGET pImage & uImage ???
Message-ID: <20030918183357.GG6692@ip68-0-152-218.tc.ph.cox.net>
References: <3F65917D.1020502@imc-berlin.de> <20030915150935.GB29517@ip68-0-152-218.tc.ph.cox.net> <3F699255.4050000@imc-berlin.de> <20030918180834.GC6692@ip68-0-152-218.tc.ph.cox.net> <20030918182654.GA1444@mars.ravnborg.org>
Mime-Version: 1.0
In-Reply-To: <20030918182654.GA1444@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 18, 2003 at 08:26:54PM +0200, Sam Ravnborg wrote:
> > What I want is three things:
> > 1) The 'mkimage' target must be done in such a fashion that it will
> > never run into a 'cannot execute' problem. My suggestion is to have
> > the Makefile do a:
> > @chmod +x mkimage.sh
> > Or so. In 2.5/2.6, the build system will handle this for you,
> > automagically, on .sh files I believe. For 2.4, you must handle this
> > explicitly.
>
> In 2.6 you need to locate the script in scripts/ and add it to the
> makefile to make this happen. Do not do that.

There's an arguement for putting this in scripts/, and that is that
U-BOOT is not a PPC-specific bootrom anymore, as it looks like you well
know. :)

> Best way IMO is to use:
> $(CONFIG_SHELL) mkimage.sh

Brain, how about this for your patch for 2.4 at least (if we can't
convince Sam to put mkimage.sh into scripts/) :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
