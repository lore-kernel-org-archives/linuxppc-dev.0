Date: Sun, 28 Jan 2001 00:09:29 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010128000929.A9218@allspice.cs.swarthmore.edu>
References: <20010126160441.B16573@allspice.cs.swarthmore.edu> <Pine.LNX.4.10.10101262206390.1670-100000@zirkon.biophys.uni-duesseldorf.de> <20010127163115.B2695@allspice.cs.swarthmore.edu> <20010127195924.A19744@allspice.cs.swarthmore.edu> <20010127202500.A21618@allspice.cs.swarthmore.edu> <20010127213401.A26295@allspice.cs.swarthmore.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010127213401.A26295@allspice.cs.swarthmore.edu>; from eisenbud@cs.swarthmore.edu on Sat, Jan 27, 2001 at 09:34:01PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 27, 2001 at 09:34:01PM -0500, Daniel Eisenbud <eisenbud@cs.swarthmore.edu> wrote:
> Maybe the next thing to do (why didn't I think of this sooner?) is to
> strace cdrdao and cdrecord and see what system call they're really
> hanging in, and what difference there is between what they do in dao
> mode and what they do in tao mode.  More later!

Attached is strace output from cdrdao.  I honsetly can't make much of
it, but maybe someone else will be able to?  I'm not sure if it hung in
the last read or the last write.  I think it was the last read, because
strace printed part of that line and then its output file (which I put
on a ramdisk, and tarred to a floppy from there, so I wouldn't have to
copy it by hand once my SCSI bus was useless) didn't change for a while,
and then the read line finished printing.  There's probably a way to
make strace print timestamps, and I'll do that tomorrow (as well as
doing this with cdrecord in both disk-at-once and track-at-once modes to
be able to compare them.

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
