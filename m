Date: Sun, 28 Jan 2001 00:11:47 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010128001147.B9218@allspice.cs.swarthmore.edu>
References: <20010126160441.B16573@allspice.cs.swarthmore.edu> <Pine.LNX.4.10.10101262206390.1670-100000@zirkon.biophys.uni-duesseldorf.de> <20010127163115.B2695@allspice.cs.swarthmore.edu> <20010127195924.A19744@allspice.cs.swarthmore.edu> <20010127202500.A21618@allspice.cs.swarthmore.edu> <20010127213401.A26295@allspice.cs.swarthmore.edu> <20010128000929.A9218@allspice.cs.swarthmore.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <20010128000929.A9218@allspice.cs.swarthmore.edu>; from eisenbud@cs.swarthmore.edu on Sun, Jan 28, 2001 at 12:09:29AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Oops, I forgot to actually attach the file.  If anyone wants to see this
and has trouble with reading MIME attachments, just email me and I'll
send you a plaintext copy -- I figured I compress and attach it to spare
the whole list a 20K email.

-Daniel

On Sun, Jan 28, 2001 at 12:09:29AM -0500, Daniel Eisenbud <eisenbud@cs.swarthmore.edu> wrote:
> Attached is strace output from cdrdao.  I honsetly can't make much of
> it, but maybe someone else will be able to?  I'm not sure if it hung in
> the last read or the last write.  I think it was the last read, because
> strace printed part of that line and then its output file (which I put
> on a ramdisk, and tarred to a floppy from there, so I wouldn't have to
> copy it by hand once my SCSI bus was useless) didn't change for a while,
> and then the read line finished printing.  There's probably a way to
> make strace print timestamps, and I'll do that tomorrow (as well as
> doing this with cdrecord in both disk-at-once and track-at-once modes to
> be able to compare them.

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

--UlVJffcvxoiEqYs2
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="cdrdao.log.0.gz"
Content-Transfer-Encoding: base64

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

--UlVJffcvxoiEqYs2--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
