Message-ID: <3BE85B0C.BCE07811@mvista.com>
Date: Tue, 06 Nov 2001 15:50:04 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: John F Davis <johndavi@us.ibm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mvista 2.0 cdk and login username and password
References: <OFC00EF5EC.1C13B6AA-ON85256AFC.006E1C01@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John F Davis wrote:
>
> Hello Mark,
>
> I don't have a /etc/passwd file.  Thus I can't login.  I didn't use the
> install script.  I just installed the rpm's by hand

If you don't use the installer script then your environment may not be
correct and you may be (and probably are) installing things out of
order.  Without the proper environment and order, post install scripts
may not run correctly (and in the case of initscripts and shell script
most likely won't.)

> like we did in cdk 1.2. i.e rpm -ivh --ignorearch *.rpm.  I didnt want to
> use the script because I didn't use the
> cdrom.  I had a copy of the cdrom filesystem mounted via AFS.  The script

This isn't CDK 1.2.  Things have been radically improved, and by having
additional features you need to use the installer.  Page 20 of the
manual provided on the CD explains the --hhlimage option.

> seems to think it is only used via a cdrom or mountable media.

Any place in the system can be used as long as the CD directory
structure is maintained.

> I figured it would be easier to just install all the rpm's rather than try
> to patch your script.  I already have problems installing

Well it's not.

> both a 405 CDK and 750 CDK on the same machine.  I get errors about rpm
> conflicts with common files.  My coworker says mvista has
> released a patch for this, but I haven't tried using it yet.

Again, this is handled by the installer.  If you have a problem (when
using the installer) contact your support representative.  They will
handle these issues!

> I will try to reinstall the passwd package again by hand.  However, I don't
> see how installing the rpm manualy would cause
> it not to create the /etc/passwd file.  I also don't understand why the rpm
> which creates the files doesnt register with the rpm database
> that it owns the file.  ie. 'rpm -q -f
> /opt/hardhat/devkit/ppc/7xx/target/etc/passwd' comes up blank.

The RPM _DOES NOT_ own those files.  No RPM owns those files.  They are
created by a post install script!

> Also, I didnt see anything in the install script which would make a
> etc/passwd file so it must be as you said below.  The file is
> created via a rpm.

Its not in the installer, it's in the base-passwd rpm's post install
script.

Again, if you are having problems installing, running, etc please
contact support as you/your company has obviously paid for the product!

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
