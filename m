Date: Fri, 9 Jul 2004 08:18:54 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Mark Chambers <markc@mail.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: what is the status of devfs?
In-Reply-To: <003301c465ad$04db1230$0301a8c0@chuck2>
Message-ID: <Pine.LNX.4.60.0407090817340.3813@localhost.localdomain>
References: <Pine.LNX.4.60.0407081035280.32470@localhost.localdomain>
 <003301c465ad$04db1230$0301a8c0@chuck2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 9 Jul 2004, Mark Chambers wrote:

>>
>>    probably should send this to the main kernel list, but in playing
>> around, i noticed that DEVFS_FS is labelled as both OBSOLETE and NEW,
>> but in the Kconfig file, it depends on EXPERIMENTAL.
>>
>>    it seems a bit inconsistent for anything to be simultaneously
>> EXPERIMENTAL, NEW and OBSOLETE, no?
>>
>
> I found the following in udev-FAQ:
>
> Q: Why was devfs marked OBSOLETE if udev is not finished yet?
> A: To quote Al Viro (Linux VFS kernel maintainer):
> 	- it was determined that the same thing could be done in userspace
> 	- devfs had been shoved into the tree in hope that its quality will
> 	  catch up
> 	- devfs was found to have fixable and unfixable bugs
> 	- the former had stayed around for many months with maintainer
> 	  claiming that everything works fine
> 	- the latter had stayed, period.
> 	- the devfs maintainer/author disappeared and stoped maintaining
> 	  the code.

oh, i knew devfs was on its way out, i was just curious about it being
labelled as EXPERIMENTAL, NEW and OBSOLETE all at the same time.

what's the story on proposed udev support some day?

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
