Date: Tue, 27 Jul 2004 17:38:59 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Mark Chambers <markc@mail.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: more questions about 8xx microcode patches
In-Reply-To: <015b01c4741d$aca87010$0301a8c0@chuck2>
Message-ID: <Pine.LNX.4.60.0407271736520.7534@localhost.localdomain>
References: <Pine.LNX.4.60.0407271546570.7005@localhost.localdomain>
 <015b01c4741d$aca87010$0301a8c0@chuck2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 27 Jul 2004, Mark Chambers wrote:

> Robert,
>
> I know I've never had a need to use a microcode patch.  Maybe a quick
> survey - has anybody ever had a need to use two patches at once?  I'm
> suspecting you may be putting a lot of effort into something that's rarely
> needed.  Also, as Motorola updates their silicon the patches will likely
> become less relevant (less likely that new users will need the patches).

on my project alone, we've needed two different selections of those
patches.  so while it's not an earth-shattering modification, it
doesn't hurt and it sometimes helps.  and it makes the addition of any
future patches really trivial, if that ever happens.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
