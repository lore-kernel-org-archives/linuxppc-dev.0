Reply-To: "Todd Inglett" <tinglett@vnet.ibm.com>
Message-Id: <3A1A9E68.E1BD9072@vnet.ibm.com>
Date: Tue, 21 Nov 2000 10:10:16 -0600
From: Todd Inglett <tinglett@vnet.ibm.com>
Mime-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: bitops porting question
References: <3A1A6E42.43E8663D@vnet.ibm.com> <20001121152056.A21375@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andi Kleen wrote:
>
> iirc David Miller did a big sweep of such things in the generic source
> when doing the sparc64 port which has exactly the same problem.
> To make sure you should probably define the macro so that you get
> a warning for &flags being anything that unsigned long, e.g. using
> a inline with a prototype and do a regular grep of the tree if anything
> shows these warnings.

Cool.  I was hoping sparc64 cleaned some of this up.  I don't read sparc
asm very well and for lack of comments in sparc64's bitops.S I wasn't
sure if it went 64 bit or not.  I'll change the prototypes to catch
offenders.

BTW, it appears to be working.
--
-todd

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
