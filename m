Date: Sat, 29 Mar 2003 09:58:40 +0100
From: Boris Bezlaj <boris@gajba.net>
To: Remco Treffkorn <remco@rvt.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.x swim3 performance problem on PM4400 identified
Message-ID: <20030329085840.GA529@gajba.net>
References: <16004.27866.270601.561756@gargle.gargle.HOWL> <20030328212513.GA456@gajba.net> <200303281813.31378.remco@rvt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200303281813.31378.remco@rvt.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 28, 2003 at 06:13:31PM -0800, Remco Treffkorn wrote:
> On Friday 28 March 2003 13:25, Boris Bezlaj wrote:
> > There seem to be some old problems when reading
> >
> > (also in 2.2 / 2.4 w/o your patch):
> > | swim3: expected cyl 3, got 4
> > | swim3: expected cyl 4, got 5
> > | swim3: expected cyl 5, got 6
> > | ....and so on until everything is loaded
> >
> > most notable when loading commpressed filesystem image at boot.
> >
>
> I do not believe it is related to bad floppies.

No, this is clearly a driver problem. I don't know much about floppy
operation but i think the driver should handle this better..

--

  Boris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
