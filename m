Date: Wed, 15 Nov 2000 16:52:31 +0200
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dink32 downloads
Message-ID: <20001115165231.C27345@hectic.net>
References: <3A1291D5.71286AA7@agelectronics.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A1291D5.71286AA7@agelectronics.co.uk>; from apc@agelectronics.co.uk on Wed, Nov 15, 2000 at 01:38:29PM +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Adrian!

On Wed, Nov 15, 2000 at 01:38:29PM +0000, you wrote the following:

> Has anybody got a reliable recipe for downloading code over the serial
> port to a Sandpoint running dink32 (version 12, rev 0)? I'd prefer to do
> it from Linux, but right now I'd accept NT.

I work with the Sandpoint via minicom, and upload the files via
ascii-xfr. In minicom I give it the command 'sb -k 38400', then change
the speed in minicom (Alt-P G Enter; may be mistaken, reciting from
memory), and then type on the command line 'ascii-xfr -svn file >
/dev/ttyS0' . It then uploads the file fine at 38400. (You have to
make sure the file has Unix-style newlines, though.)


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

I drive way too fast to worry about cholesterol.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
