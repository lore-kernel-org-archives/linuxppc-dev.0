Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v0401011ab3b41fd01347@power.elec.kitami-it.ac.jp>
In-Reply-To: <19990715184120.A7216@drow.res.cmu.edu>
References: <99071600025900.06989@ns1102.munich.netsurf.de>; from Franz
 Sirl on Thu, Jul 15, 1999 at 11:57:13PM +0200
 <4.2.0.58.19990715163648.05778290@mail.lauterbach.com>
 <99071600025900.06989@ns1102.munich.netsurf.de>
Date: Fri, 16 Jul 1999 08:31:28 +0900
To: linuxppc-dev@lists.linuxppc.org
From: "T.Ueda" <ueda@power.elec.kitami-it.ac.jp>
Subject: Solved! Fortran call from C on LinuxPPC-R5
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks all,
The problem has been solved!

I had an easy mistake, prototype declaration.
I have added:
> int f2_(int *x);
> float f22_(int *x);
> void f3_(int *x, int *y);
> void f33_(int *x, float *y);

Tac@Japan



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
