Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3F0E0C91.1000209@irtf.ifa.hawaii.edu>
Date: Thu, 10 Jul 2003 15:02:09 -1000
From: Charles Lockhart <lockhart@jeans.ifa.hawaii.edu>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on the Virtex II Pro?- ELDK?
References: <C7FFFEA58B43D311920D0004ACE5333F0F53583A@amer25.avnet.com>
In-Reply-To: <C7FFFEA58B43D311920D0004ACE5333F0F53583A@amer25.avnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is it possible to use the ELDK to compile a simple stand alone
executable that I could download and start using my jtag interface?  I
tried compiling a really trivial piece of code with the "-static"
option, and it created a file that looks large enough to have included
everything it needs but when I download and start it, I don't see any of
the break points I'm setting being triggered.

I'd just like to do this as kind of a litmus test to show that I can
build something at least that'll execute.

-Charles Lockhart


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
