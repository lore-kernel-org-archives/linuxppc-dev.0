Date: Tue, 16 Oct 2001 00:45:36 -0500
From: Takashi Oe <toe@unlserve.unl.edu>
To: Andrew P McPherson <apm@MIT.EDU>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Compiling BootX?
Message-Id: <20011016004536.66a97985.toe@unlserve.unl.edu>
In-Reply-To: <Pine.GSO.4.30L.0110142354520.19922-100000@no-knife.mit.edu>
References: <Pine.A41.3.96LJ1.1b7.1011014224838.138592A-100000@unlserve.unl.edu>
	<Pine.GSO.4.30L.0110142354520.19922-100000@no-knife.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 14 Oct 2001 23:57:39 -0400 (EDT), Andrew P McPherson wrote:


> The problem with the MkLinux booter is that it refuses to run because it
> doesn't recognize the machine as "supported."  Is the source of the
> MkLinux booter available so that I could disable that "feature," or was
> that a closed-source effort by Apple?

It's a closed-source software.  Is the one you have version 1.4?  What's the gestalt id of your machine with PPC card?  Have you tried some software to fake the id (and change the type of apple booter from 'scri' to 'INIT' or so)?


Takashi Oe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
