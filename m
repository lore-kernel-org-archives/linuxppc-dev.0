Message-ID: <3A01A578.B2F2BF6A@mvista.com>
Date: Thu, 02 Nov 2000 09:33:44 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: John Jones <john@iigi.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Warning: unable to open an initial console.
References: <3A01842B.85FF7078@iigi.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Any ideas?  I took a look at the /opt/hardhat/devkit/ppc/8xx/target
> directory, I can find a "dev" directory but there is nothing in it.  Is
> there some RPM I need to install?  I think that I have
> downloaded/installed all of the RPM's from the mvista ftp site.
>

either you missed an RPM or you were not root when you installed. try
installing the filesystem RPM again.


Matthew Locke
Montavista Software

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
