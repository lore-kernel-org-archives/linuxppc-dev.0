Content-Type: text/plain;
  charset="iso-8859-1"
From: Trevor Woerner <ppc339@vtnet.ca>
Reply-To: ppc339@vtnet.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] educate users about x86 specific kludges instead of hiding thier ignorance
Date: Thu, 15 May 2003 23:10:50 -0400
References: <20030515074214.GA787@plato.local.lan> <v04003a06bae9957ba064@[192.168.1.4]> <20030515152245.A23204@forte.austin.ibm.com>
In-Reply-To: <20030515152245.A23204@forte.austin.ibm.com>
MIME-Version: 1.0
Message-Id: <200305152310.50885.ppc339@vtnet.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On May 15, 2003 04:22 pm, linas@austin.ibm.com wrote:
> On Thu, May 15, 2003 at 02:11:42PM -0500, Tony 'Nicoya' Mantler wrote:
> > Speaking of which, is it even possible these days to build a kernel
> > small enough for (non-b) zImage on x86? I think it's been a while
> > since I've even made one that can fit on a floppy.
>
> If you put most things into modules, then yes, its still very
> possible.

This might be hard to believe, but when I had to make small x86 kernels
(everything including compressed filesystem had to fit in 2MB) for a
little embedded device I was working with, I could usually make smaller
kernels by *not* turning on module support and simply including the
couple of modules I needed directly in the kernel. Being an embedded
device I didn't need very many extras. Enabling module support inflates
the kernel quite a bit, not to mention all the extra space for the
modules themselves and the modutils.

But yes, if you are trying to create a general kernel for a range of
devices (instead of one specific device) that have a lot of extras,
then building modules does keep the kernel size down.

I'm just trying to point out that there is a point where it makes more
sense to compile-in, rather than create modules, when trying to create
small kernels.

        Trevor

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
