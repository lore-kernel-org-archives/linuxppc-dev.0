Date: Tue, 07 Dec 1999 19:59:53 -0500 (EST)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Re: Debugging with thread(s)
In-reply-to: <0FMD0095OJDI5C@falla.videotron.net>
To: linuxppc-dev@lists.linuxppc.org,
        Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Cc: Frank McPherson <frank@mitre.org>
Message-id: <Pine.LNX.4.10.9912071954360.14771-100000@modemcable064.166-200-24.mtl.mc.videotron.net>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I could not find Lu's directory on VA's ftp site. However, I found 4.18-10
on rufus. The change log says that gdb is now thread safe.

I donwloaded the SRPMS but it contains 3 ...tar.bz2 files. I do not know
what compression format is bz2. I tried gunzip and unzip but it did not
worked. Anybody knows what format it is?

Claude

PS Once I have compiled it, what is the best way to propagate this new
version? And how? 

On Tue, 7 Dec 1999, Kevin_Hendricks wrote:

> Hi,
> 
> I use gdb to debug native threads all of the time for the jdk. You have to get a 
> version of gdb that actually has thread support and you have to have a version 
> of gdb that understands the real time signals (since they are used by both the 
> JDK and linuxthreads).
> 
> The best way to get a real working gdb is to go the H.J.Lu's ftp site at VA 
> Research (I don't remember the url right off hand but I am sure you can find it 
> if you look) and grab his latest linux specific SRPM for gdb (it is a 4.17.X) 
> and rebuild it under PPC.
> 
> This will allow you to work with real time signals and debug linuxthreads code.
> 
> Kevin
> 
> --
> Kevin B. Hendricks
> Associate Professor of Operations and Information Technology
> Richard Ivey School of Business, University of Western Ontario
> London, Ontario  N6A-3K7  CANADA   
> khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959
> 
> 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
