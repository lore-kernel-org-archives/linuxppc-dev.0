Date: Tue, 6 Nov 2001 14:32:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: John F Davis <johndavi@us.ibm.com>
Cc: Mark Hatle <fray@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mvista 2.0 cdk and login username and password
Message-ID: <20011106143221.D1776@cpe-24-221-152-185.az.sprintbbd.net>
References: <OFC00EF5EC.1C13B6AA-ON85256AFC.006E1C01@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFC00EF5EC.1C13B6AA-ON85256AFC.006E1C01@raleigh.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Nov 06, 2001 at 04:15:25PM -0500, John F Davis wrote:
>
> Hello Mark,
>
> I don't have a /etc/passwd file.  Thus I can't login.  I didn't use the
> install script.  I just installed the rpm's by hand
> like we did in cdk 1.2. i.e rpm -ivh --ignorearch *.rpm.  I didnt want to
> use the script because I didn't use the
> cdrom.  I had a copy of the cdrom filesystem mounted via AFS.  The script
> seems to think it is only used via a cdrom or mountable media.

I haven't tried AFS, but loopback is fine.  --hhlimage /mnt works for
me.

> I will try to reinstall the passwd package again by hand.  However, I don't
> see how installing the rpm manualy would cause
> it not to create the /etc/passwd file.  I also don't understand why the rpm
> which creates the files doesnt register with the rpm database
> that it owns the file.  ie. 'rpm -q -f
> /opt/hardhat/devkit/ppc/7xx/target/etc/passwd' comes up blank.

The script also does some setup of the system.  If you haven't gotten
far, re-install using the script.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
