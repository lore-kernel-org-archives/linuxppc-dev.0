Message-Id: <200103252008.OAA17663@lists.linuxppc.org>
Subject: Re: st corruption
From: Guillaume Laures <guillaume.laures@noos.fr>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tony Mantler <nicoya@apia.dhs.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.05.10103252120020.13875-100000@callisto.of.borg>
Content-Type: text/plain; charset=ISO-8859-1
Date: 25 Mar 2001 22:08:13 +0200
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Le 25 Mar 2001 21:21:20 +0200, Geert Uytterhoeven a écrit :
> On 25 Mar 2001, Guillaume Laures wrote:
> > > merida:/home/nicoya# md5sum testfile
> >
> > 13b37214355ea84d906a54bb14c1c0be  testfile
> >
> > > merida:/home/nicoya# tar -c testfile >/dev/st0
> > > merida:/home/nicoya# mv testfile testfile.1
> > > merida:/home/nicoya# tar -x </dev/st0
> > > merida:/home/nicoya# md5sum testfile
> >
> > 13b37214355ea84d906a54bb14c1c0be  testfile
> >
> > uname -a :
> > Linux shiner.gom.net 2.2.18-snd-bkport #26 Wed Feb 28 23:19:57 CET 2001
> > ppc unknown
> >
> > So no prob here either with close hardware.
>
> Thanks! Do you also have a 2.4.x kernel around?

Not yet for this machine, but soon. I'll keep you tuned.

I may do test on my G4 with an external enclosure (2.4.3-pre3, scsi =
sym53c1010-33-0 through sym53c8xx-1.7.3a-20010304)

Later,


--
GoM


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
