From: Gerd Knorr <kraxel@goldbach.in-berlin.de>
Date: Thu, 4 Mar 1999 20:51:55 +0100
Message-Id: <199903041951.UAA00814@macintoy.masq.in-berlin.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME 2306 almost up and running
In-Reply-To: <Pine.SO4.4.05.9903041715480.4479-100000@hsins.uia.ac.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Hi,
> 
> My final question : our board now finally boots, it can mount an
> NFS partition as root fs, but does anybody know where on the Internet
> I can find a file system tree with the binaries for LinuxPPC ? I mean,
> like Slackware, but for LinuxPPC. (We have no other [spare] PPC based
> machines, so I need a full binary file tree to set up on the NFS fs).

Just download the basic rpm's and install them on the NFS Server
with "rpm --root=/export/nfsroot4ppc -i *.rpm".

  Gerd


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
