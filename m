Date: Fri, 7 May 1999 23:15:25 +0200 (CEST)
From: Philipp Tomsich <mac@mars.zserv.tuwien.ac.at>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Partitions > 2GB?
In-Reply-To: <Pine.LNX.4.10.9905061642580.3082-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.4.03.9905072308590.20829-100000@mars.zserv.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 6 May 1999, Geert Uytterhoeven wrote:

> Once upon a time, there was a bug in fdisk preventing it to work with disks
> larger than 2 GiB on PPC.

As far as I remember it, there also was a problem with the return value of
llseek in some versions of the glibc. As a consequence, mke2fs was unable
to make a filesystem larger than 2gbs.

--phil.

--
Philipp Tomsich                     eMail: phil@ifs.tuwien.ac.at
Institute of Software Technology    URL: http://www.ifs.tuwien.ac.at/
Vienna University of Technology
Resselgasse 3 / E188
A-1040 Wien, AUSTRIA



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
