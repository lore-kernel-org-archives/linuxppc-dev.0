Date: Tue, 29 Jun 2004 10:45:21 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Sylvain Munaut <tnt@246tnt.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel option "Command line partition table parsing" 
In-Reply-To: <20040629143715.2AF7EC109F@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0406291044020.25188@localhost.localdomain>
References: <20040629143715.2AF7EC109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 29 Jun 2004, Wolfgang Denk wrote:

> In message <40E164A6.8060502@246tNt.com> you wrote:
>>
>> I'd suggest having a look at the comment on top of
>>
>> drivers/mtd/cmdlinepart.c
>>
>> But I'm not sure if rpxlite.c . From what I see, it may require to add
>> a "probe" to look at the command line. Someone ?
>
> It's tested and working in our version of the linuxppc_2_4_devel tree.

ok, that explains why i couldn't find it -- i'm working with the
linuxppc-2.5 bk tree.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
