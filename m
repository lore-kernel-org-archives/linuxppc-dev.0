Date: Sat, 24 Apr 1999 22:35:04 +1000
Message-Id: <199904241235.WAA25761@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: paubert@iram.es
CC: dje@watson.ibm.com, linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.HPP.3.96.990420223651.20020P-100000@gra-ux1.iram.es>
	(message from Gabriel Paubert on Tue, 20 Apr 1999 22:43:24 +0200
	(METDST))
Subject: Re: Current egcs, binutils and kernel (fwd)
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.HPP.3.96.990420223651.20020P-100000@gra-ux1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert <paubert@iram.es> wrote:

> to correctly implement this. And then I've noticed just after that people
> do more work than necessary in the cvt_df and cvt_fd routines: floating
> point loads and stores never affect or depend on the FPSCR contents, so

Arrghl, you're right.  I had thought you could get overflows or other
errors being signalled, that's why I had the fpscr load/save in there,
but it appears from the manual that I was wrong.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
