Date: Mon, 2 Aug 1999 13:27:14 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Naushit Sakarvadia <nsakarvadia@telogy.com>
cc: "'LinuxPPC Developpers'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: off topic help
In-Reply-To: <61891BA043DED21180920090273F173829B0F0@argentina.telogy.com>
Message-ID: <Pine.A41.3.96LJ1.1b7.990802132335.74770B-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2 Aug 1999, Naushit Sakarvadia wrote:

> Hello,
> 
> I apologize in advance for asking offtopic question.
> 
> * can I run rpm without Super user previlege?
> * how can I install the package other then /usr/local?

Try rpm's --root option.  If you just need to extract binaries from a
package, try rpm2cpio + cpio.


Takashi Oe


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
