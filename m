Message-ID: <4087EBAD.1070803@kegel.com>
Date: Thu, 22 Apr 2004 08:58:37 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'etux@embeddedtux.org'" <etux@embeddedtux.org>
Subject: Re: good learning experience for Linux
References: <D73A25AA6E54D511AD74009027B1110F5BB1A2@ORION>
In-Reply-To: <D73A25AA6E54D511AD74009027B1110F5BB1A2@ORION>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Blakeslee wrote:
> I sent a message earlier today about getting a "swap_dup: Bad swap file
> entry 0e18d55c" error.  I found the problem and fixed it and wanted to share
> it with people who are still learning this stuff, like myself.
>
> After 2 days of pounding on my head I found the file
> Documentation/powerpc/cpu_features.txt  It explained how the file
> arch/ppc/kernel/cputable.c has a list of the known powerPC PVRs(processor
> version register).  The 8248 was not in there so it was using a default
> entry.  That was the cause of my problems.  I added a new entry for the 8248
> and all is working.  My lesson was a little research makes things much
> nicer.  Lesson learned.

So, is this already in the latest kernel sources?  If not,
have you considered sending in a patch?
- Dan

--
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
