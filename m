Date: Mon, 28 Jun 2004 06:50:13 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading the kernel and root FS separately from flash? 
In-Reply-To: <20040628104159.87EEDC109F@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0406280642220.4278@localhost.localdomain>
References: <20040628104159.87EEDC109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 28 Jun 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0406280600140.3259@localhost.localdomain> you wrote:

>> that it could be read-only).  how hard would it be to automatically
>> have that root FS copied from JFFS2 to RAM and mounted from there?
>
> This makes just no sense to me.

ok, i'm probably getting confused about something fundamental here.
what i'm after is to have my root filesystem in persistent storage and
available for updates on the fly, hence the notion of partitioning off
a part of the system flash for the JFFS2 version of the root
filesystem.  i've done that, so i've solved that problem -- i have a
root filesystem i can mount from a running system and modify.

now, i could just mount that JFFS2 version of the root fs straight out
of flash, but i get the impression that that would cause a performance
hit.  so i was wondering about the feasibility about copying that
entire flash FS into RAM at boot time, and running out of RAM.  this
would mean, of course, that if i wanted to make mods to the root FS,
i'd do them in flash and they'd only take effect at the next reboot,
which is fine with me.

or am i just hopelessly confused about what is and is not a reasonable
option here?  i get the feeling i'm missing something important.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
