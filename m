Message-ID: <0F48024310E5D6118D200002B3A440DB08B079E9@zil01exm08.mcil.comm.mot.com>
From: Meriin Michael-BMM063 <BMM063@motorola.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: baud rate question
Date: Sun, 16 May 2004 12:50:21 +0300
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Are you sure that you are using the same definition  of "bd_t" in u-boot and in Linux?
You have to include the file named ppcboot.h instead of the bd_t definition, this definition is located in your platform
definition include file like rpxlite.h

Best Regards,
     Michael Meriin



-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Brian Hawley
Sent: Thursday, May 13, 2004 19:39
To: linuxppc-embedded@lists.linuxppc.org
Subject: baud rate question



Forgive the obvious newbie question, but we've tried everything, reviewed
the readme's, etc.

We are using the linux-2.5-ocp tree from bk.

We are using u-boot 1.0.0.

We set u-boot to 38400 in the config.  linux wants to be 9600 by
default.  So, we realize
that we can't see the kernel boot up.

We've tried changing u-boot back to 9600, but haven't been able to.

Is there a way to tell linux to come up at a different baud rate?  We've
tried the earlyserialpk option, and the console options...but no luck.

Thanks for any assistance.

-- Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
