Date: Wed, 24 Jul 2002 09:21:40 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: Wolfgang Denk <wd@denx.de>
Cc: Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to get rid of unused data in LKM 
In-Reply-To: <20020724154914.5C03C10875@denx.denx.de>
Message-ID: <Pine.LNX.4.30.0207240919480.3743-100000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > But after doing so, the firmware data is still wasting kernel memory on the host system
> > and is not used anymore.
> > How can I free that memory ? Is there a better way to handle that data ?
>
> If you really think you must link the data with the  module:  Declare
> it using "__initdata" ?

I was under the impression that data like this is not thrown away when
compiled as a module... only when compiled directly into the kernel. Is
this not true?

I think Wolfgang's ioctl idea is a much better way to go in this case.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
