Date: Tue, 30 Mar 1999 22:40:34 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: "Charles E. Leiserson, Jr." <locutus@MIT.EDU>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.5 on an iMac 
In-Reply-To: <199903310115.UAA23379@all-night-tool.mit.edu>
Message-ID: <Pine.LNX.3.96L.990330223921.27821A-100000@unix48.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 30 Mar 1999, Charles E. Leiserson, Jr. wrote:
> 
> > Everything compiled fine but when I try to boot it (by putting vmlinux in
> > the same directory as bootx) it sits there at after it detects the ide
> > devices.
> 
> vmlinux needs to go in the System Folder to be seen by BootX.

It doesn't; check the Readme for the latest BootX. Obviously, BootX found
enough of the kernel to boot from it...

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
