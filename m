To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: Mac-on-Linux
References: <19990519235050.60265@ibrium.se> <Pine.LNX.3.96.990519210752.5706A-100000@EdMcMan.Dyn.Ez-Ip.Net> <19990520192459.17170@ibrium.se> <19990520171823.A409@jasons.dyn.kpn.cx> <87zp2ysaku.fsf@hades.nocrew.net> <19990521203719.44590@ibrium.se> <87so8qp44p.fsf@hades.nocrew.net> <19990522020440.49547@ibrium.se>
Content-Type: text/plain; charset=US-ASCII
From: Stefan Berndtsson <stefan@nocrew.org>
Date: 22 May 1999 09:15:27 +0200
In-Reply-To: Samuel Rydh's message of "Sat, 22 May 1999 02:04:40 +0200"
Message-ID: <87n1yxo9rk.fsf@hades.nocrew.net>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Samuel Rydh <samuel@ibrium.se> writes:

> No. There is a hardware independent video driver which uses
> the framebuffer device. Does singlestepping (Meta-S) work? 
> Also, remeber to specify 'processor: 4' in the molrc file.
> 
> Btw. I've uploaded a new release of Mac-on-Linux (with
> binaries) which works properly on G3 machines. It is possible 
> that the G3 fix also solves the 603 problem.

I've compiled the new one, and patched the kernel as well
with the newest patches for that.

The result is identical to me. Meta-S gives the same hanging 'mm',
as Meta-G does, which seems to be resolvable only by a Ctrl-C,
which then exists the program.

I am specifying '4' as processor too..

/Stefan

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
