From: Joshua Gargus <gargus@cs.ualberta.ca>
To: LinuxPPC Development Mailing List <linuxppc-dev@lists.linuxppc.org>
Subject: DMA sound compatability with OSS API
Date: Mon, 5 Jul 1999 00:44:58 -0600
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99070500554905.22100@24.65.216.209.ab.wave.home.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-----BEGIN PGP SIGNED MESSAGE-----

Hello,

I'm trying to compile an application (the virtual machine for Squeak 
Smalltalk) that requires several ioctl() calls defined in 'soundcard.h', 
including 'SNDCTL_DSP_GETCAPS' and 'SNDCTL_DSP_GETOSPACE'.
These are not defined in 'drivers/sounds/dmasound.c', although the 
comment at the top of the file declares it to be 'OSS compatable'.

I don't know too much about this stuff at all.  Is there some reason that
the Macintosh sound hardware cannot support these calls, or have they
just not been implemented yet?  Is adding support for these calls in the
works, or is it an itch I'll have to scratch for myself?

Thanks,
Josh
-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
MessageID: o8pJk7aZZUqYQcdDtvEGZYJUhah7A8qv

iQA/AwUBN4BW+W99D+Gh4jVMEQLwxwCfXzwAw6+QnpyD0tCwKKYB4r3cmtwAoOrY
/jKA/04Xm9i98WBZ6+QvOgBG
=rZGz
-----END PGP SIGNATURE-----

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
