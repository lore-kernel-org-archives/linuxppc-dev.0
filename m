Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 27 Jul 2004 17:36:26 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Dan Malek <dan@embeddededge.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: more questions about 8xx microcode patches
In-Reply-To: <81B2FD02-E014-11D8-96F8-003065F9B7DC@embeddededge.com>
Message-ID: <Pine.LNX.4.60.0407271733200.7504@localhost.localdomain>
References: <Pine.LNX.4.60.0407271546570.7005@localhost.localdomain>
 <81B2FD02-E014-11D8-96F8-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 27 Jul 2004, Dan Malek wrote:

> On Jul 27, 2004, at 4:23 PM, Robert P. J. Day wrote:

>>   it seems that creating a menu of 8xx microcode patches would be
>> fairly easy:
>
>
> Hahahahaha!!!!  You don't know how big of a hole you are digging :-)

oh, fer shure.  :-)  but given that there are three clear and
identifiable patches that exist at the moment, i'll put together a
patch that turns them into a submenu and submit it, and you can decide
what to do with it.  i'll make sure that the submission doesn't change
any of the current functionality, just makes it easier to pick what
you want.

(specifically, it's inconvenient to be able to select one patch via
Kconfig, and the other only by editing micropatch.c.  but give me a
bit, and i'll post something based on those other two small patches i
submitted.)

rday

p.s.  should patches be submitted as main body in postings, or as
attachments?  or do you care?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
