Mime-Version: 1.0
Message-Id: <v04220800b5f2c0d86aa2@[10.0.0.42]>
In-Reply-To: <19340818034744.27131@192.168.1.10>
References: <v04220800b5f21601b44d@[10.0.0.42]>
 <19340818034744.27131@192.168.1.10>
Date: Sat, 23 Sep 2000 13:23:08 -0700
To: Benjamin Herrenschmidt <bh40@calva.net>, <linuxppc-dev@lists.linuxppc.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: MacOS X and yaboot wars.
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:16 PM +0200 9/23/00, Benjamin Herrenschmidt wrote:
>>
>>Interestingly enough, I noticed this tidbit in their BootX script:
>>
>>-------------------------------------------
>>if 0 0 then
>>
>>
>>-------------------------------------------
>>
>>Implying that they may be doing something with ext2 support.
>
>You "tidbit" was empty ;)

It sure didn't look that way when I wrote it in Eudora!  And in fact
it made it through to Ethan Benson, who was CC'ed.  Maybe the mailing
list software mangled it.

Bizarre.

>They have indeed ext2 support in their "BootX". They have ELF support.
>They have almost everything needed to boot the Linux kernel as well. I
>need to implement the necessary support in the kernel itself to get it
>working.

Cool!  Do you know if their "BootX" is under their open source license?

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
