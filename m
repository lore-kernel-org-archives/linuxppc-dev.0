Date: Mon, 28 Jun 2004 06:52:46 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading the kernel and root FS separately from flash? 
In-Reply-To: <20040628104822.6C3BFC109F@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0406280650410.4311@localhost.localdomain>
References: <20040628104822.6C3BFC109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 28 Jun 2004, Wolfgang Denk wrote:

> We got the fastest boot and run times using a  read-only  ext2  file-
> system in a MTD partition.

ah, now i see what i was overlooking -- having a straight ext2 FS in
flash from the beginning and i'm pretty sure i can mount it read-only.
i think that might just do it, although i'm still going to look into
that overlay paper and the cramfs option.  just to round out my
education.  thanks.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
