Date: Tue, 4 Apr 2000 15:10:39 -0400 (EDT)
From: Jeff Carr <jcarr@linuxppc.org>
To: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Install on a Pismo (going bad)
In-Reply-To: <p04310100b50f59297908@[134.114.15.89]>
Message-ID: <Pine.LNX.4.10.10004041509250.13450-100000@mail.linuxppc.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Second (the more major problem), is that somehow the partition table
> on my hard drive got all screwed up.  Now the LinuxPPC installer
> tells me it can't read the partition table, and doesn't understand
> where my hard drive is.  I tried booting back into MacOS and using a

What does perldisk see? If perldisk exits abnormally, that's a bad sign,
if it doesn't see any drives, then it's a kernel issue.
jcarr


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
