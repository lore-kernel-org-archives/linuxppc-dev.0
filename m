Date: Thu, 19 Oct 2000 02:16:53 +1100
From: Chris Leishman <masklin@debian.org>
To: Xavier Grave <grave@ipno.in2p3.fr>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: initial console
Message-ID: <20001019021653.A383@nina.dev.fol>
References: <Pine.LNX.4.21.0010181110280.24224-100000@ipnpcu5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0010181110280.24224-100000@ipnpcu5>; from grave@ipno.in2p3.fr on Wed, Oct 18, 2000 at 11:25:48AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 18, 2000 at 11:25:48AM +0200, Xavier Grave wrote:
>
> Hi,
>
> I have the following message at boot :
>
> Freeing unused kernel memory: 220k init 12k pmac 4k chrp 4k openfirmware
> Warning: unable to open an initial console.
> Kernel panic: No init found.  Try passing init= option to kernel.
> Rebooting in 180 seconds..
>
> if I give this argument init=/sbin/init it's the same.
>

I know it sounds dumb, but have you ensured that you've got the root partition
set correctly?  I've seen these errors before when I had a root partition
specified that didn't contain /dev or /sbin/init.

Perhaps add root=/dev/<whatever it is for you> as another arguemnt.

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
