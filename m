From: Gerd Knorr <kraxel@goldbach.in-berlin.de>
Date: Wed, 7 Apr 1999 22:59:23 +0200
Message-Id: <199904072059.WAA00714@bogomips.masq.in-berlin.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Uhh...Where Is The Source?
In-Reply-To: <199904071702.MAA15337@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In lists.linuxppc.dev, you wrote:
> 
> I can't find any source code for the LinuxPPC applications. I've been going 
> around in circles trying to find ".c" files for fetchmail, sendmail, vim, etc. 
> Every directory in /src, /etc, and such seems to have an "SRPMS" or "RPMS" 
> directory in it which, themselves have "SRPMS" and "RPMS" directories...which 
> makes me confused.

SRPMS is hot:

macintoy root /vol/cdrom/SRPMS# rpm -qlp fetchmail-4.4.7-1a.src.rpm
fetchmail-4.4.7.tar.gz
fetchmail.gif
fetchmail.spec

The first one is the original source package.

  Gerd


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
