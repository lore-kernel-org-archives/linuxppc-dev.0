Message-ID: <36764C54.D14B5FC2@alien.bt.co.uk>
Date: Tue, 15 Dec 1998 11:47:32 +0000
From: Mad Cow <0xdeadbeef@alien.bt.co.uk>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Installing pre-R5
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-----BEGIN PGP SIGNED MESSAGE-----

Pre-R5 will not install, at least not on my 7600. Here are my
observations;

* You need to use a recent (ie >2.1.130) kernel with BootX to let the
keyboard work properly.

* The NFS install hangs after you give it the NFS server details. I
get a flashing white cursor on a black line at the bottom of the
screen. Unfortunately, my keyboard is without F-keys, so I can't get a
shell up to see what is going on here.

* The FTP install gets a little further. After reading the
supplimentary disk, it complains about some errors in base/comps
(packages not found). I continue regardless, selecting ``Install
Everything'', but it barfs reading the first rpm.

I take it only a local install works? I can't easily try this.

Cheers,

/.J

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3ia
Charset: noconv

iQCUAwUBNnZLiBmu4UPZlmdBAQFqeQP0CawGgAlNjXEmrVEkLUn01Mwr2uV+YNmS
7AsB+B1EICYs7ZHGKkSjk3qv5hAhFMhY51AKPoD6kbiejj4BgkhfZNalb6sJlDuv
fq8SKzvt0EX98eqCLgi1QMyW/OcqHiiSsrCReCw2BKgRwm2ISUAoRYH4H5IOVDOM
F2f1XLkKQA==
=NZvQ
-----END PGP SIGNATURE-----

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
