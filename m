In-Reply-To: <Pine.LNX.4.10.9911180520580.616-100000@PetesBox.localdomain>
Date: Thu, 18 Nov 1999 11:40:50 +0100
To: phandel@cise.ufl.edu, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Extreme swapping / new location of Paul's kernels [was Re: Kernel debugging??]
Message-Id: <19991118114050.012345@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 18, 1999,  <phandel@cise.ufl.edu> wrote:

>I'm having a hard time blaming BootX - top did reveal an incorrect amount
>of memory (total/free/etc.) but I've heard that top is broken in the 2.3
>series.  I'll grab Paul's new 2.3.28 rsync later tomorrow and look at the
>memory.

There is a possibility that BootX passed an incorrect device tree size or
something like that that would mess up the kenrel memory management. I
didn't see this happen, but I'll have a second look at the code.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
