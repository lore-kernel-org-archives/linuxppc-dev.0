Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How Can The Starting Address Of An Image In ELF File BeChanged
To: "Stephen Williams" <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF243EF967.6B4324CF-ON65256E4E.00240CC6@lntinfotech.com>
From: "Thamarai Selvan" <Thamarai.Selvan@lntinfotech.com>
Date: Fri, 5 Mar 2004 12:03:55 +0530
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi

iam still not clear with it
can u guide me 2 some document/link on it or brief it little bit more
why it is linked to that address ?
if it is linked it should be configurable
bcuz iam using vision ice to download my image.
Thanks for your immediate reply

with regards
Thamarai Selvan.G

[ "Stephen Williams" <612dlag102@sneakemail.com> writes: ]

Thamarai Selvan Thamarai.Selvan-at-lntinfotech.com |PPC Linux Embedded| wrote:
>
> I created the elf file of the kernel using "make vmlinux", when i
> checked the created system.map i found the the kernel image starting
> from 0xc0000000. Can any tell where this address is defined or
> configured? and how can this be changed to 0x0000000 is it possible?

The linux cernel is linked to 0xc0000000, and the entry is really up
there. In fact, the kernel is loaded starting at 0x0, and there is code
at the beginning that turns on address translation so that it appears at
the right place.

In other words, there is nothing for you to change.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
