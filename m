Message-ID: <D73A25AA6E54D511AD74009027B1110F5BB1A3@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Dan Kegel'" <dank@kegel.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'etux@embeddedtux.org'" <etux@embeddedtux.org>
Subject: RE: good learning experience for Linux
Date: Thu, 22 Apr 2004 12:08:51 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I still have so more to do like verifying FEC and PCI.  Also I did it on 2.4
which I believe is done or close to being.  I can provide a patch when I am
done.

-----Original Message-----
From: Dan Kegel [mailto:dank@kegel.com]
Sent: Thursday, April 22, 2004 11:59 AM
To: Steven Blakeslee
Cc: 'linuxppc-embedded@lists.linuxppc.org'; 'etux@embeddedtux.org'
Subject: Re: good learning experience for Linux


Steven Blakeslee wrote:
> I sent a message earlier today about getting a "swap_dup: Bad swap file
> entry 0e18d55c" error.  I found the problem and fixed it and wanted to
share
> it with people who are still learning this stuff, like myself.
>
> After 2 days of pounding on my head I found the file
> Documentation/powerpc/cpu_features.txt  It explained how the file
> arch/ppc/kernel/cputable.c has a list of the known powerPC PVRs(processor
> version register).  The 8248 was not in there so it was using a default
> entry.  That was the cause of my problems.  I added a new entry for the
8248
> and all is working.  My lesson was a little research makes things much
> nicer.  Lesson learned.

So, is this already in the latest kernel sources?  If not,
have you considered sending in a patch?
- Dan

--
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime
change

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
