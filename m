Date: Mon, 7 Dec 1998 14:47:17 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: VALETTE Eric <valette@crf.canon.fr>
cc: cort@persephone.cs.nmt.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: Incomplete (potentially broken) Raven Chipset support for PREP
 machines.
In-Reply-To: <m0zlzYS-0000WWC@tri-yann.crf.canon.fr>
Message-ID: <Pine.LNX.4.04.9812071441070.13527-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Dec 1998, VALETTE Eric wrote:

> 3) Once the PCI Configuration space routine have been correctly set,
> If the raven is detected, then why not enabling the OPENPIC and use
> the open_pic code provided by CHRP machines?
> 
> At least this would remove the hugly code for PCI interrupt mapping
> and enable to support correctly multi-function devices...
> 
> Note : I'm asking theses questions because I will work on this code.
> The better I understand it, the sooner I may send patches. I have
> 10 years of OS programming behind me (Chorus) but I'm totally new to
> PPC (1 month or so) so please be patient...
> 

OpenPic support for Raven, and in turn, SMP for the MTX boards, is on my
list of things to work on in the next month or so.

I started working on an 'architecture' for detecting various things like
this and setting appropriate function pointers at boot time. I got as far
as redoing the RTC reading/setting code. (since the setting the clock
didn't work on my MTX)

Please let me know if you get any patches made.

--------------------------------------------------------------------------
| Troy Benjegerdes    |    troybenj@iastate.edu    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
