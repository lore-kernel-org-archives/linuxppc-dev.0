Message-ID: <3BB0A038.8DC2C9@mvista.com>
Date: Tue, 25 Sep 2001 10:18:16 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Cindy Peters <cinpet@adaptivemicro.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross-compiling standard utilities for MPC823
References: <41EDEC3C1B88D51186EB00A0C9CFADF702FA88@AMWMAIL>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cindy Peters wrote:
>
> I am attempting to cross-compile the file utilities that I downloaded from
> the linuxppc ftp site for the MPC823 on an x86 PC running Redhat 6.2. I am
> getting an error when configure is trying to determine the byte ordering.
> Following is a clip from the config.log file.

It sounds like your cross-gcc is messed up.  Have you tried the
MontaVista one?  it should be at ftp.mvista.com/Journeyman/  however, we
are currently having problems with the FTP site.. I hope it's back up
soon.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
