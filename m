Date: Mon, 23 Aug 1999 21:42:11 -0600 (MDT)
From: Dan Burcaw <dburcaw@terraplex.com>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: USB 1.16 support?
In-Reply-To: <Pine.LNX.3.96L.990823202809.10874B-100000@unix47.andrew.cmu.edu>
Message-ID: <Pine.LNX.4.10.9908232139560.2393-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis,

The newer shipping B&Ws and iMacs do have USB 1.16. I've patched UUSBD to
make it work. See
ftp://ftp.yellowdoglinux.com/pub/yellowdog/kernel/patches/linux-2.2.6-uusbd.patch


Regards,
Dan

On Mon, 23 Aug 1999, Hollis R Blanchard wrote:

> 
> I think the new (333 MHz) iMacs and new B&W G3's are being shipped with
> keyboards and/or mice that require USB 1.16, and current Linux support is at
> 1.10. Could someone confirm this is the case?
> 
> I read a while ago about someone who disabled the version checking code in the
> USB stack and got a 1.16 device or two to work. Can anyone comment on that?
> Is that approach generally valid, at least until 1.16 support is there? And is
> 1.16 that much different from 1.10 to make it incompatible?
> 
> -Hollis
> 
> 
> 


Dan

Yellow Dog Linux for Apple G3 and PowerPC
  email: dburcaw@yellowdoglinux.com
  website: http://www.yellowdoglinux.com/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
