Date: Tue, 25 May 1999 12:50:37 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Tom Rini <tmrini@ntplx.net>
cc: laures@esiea.fr, linuxppc-dev@lists.linuxppc.org
Subject: Re: Initio miles tests :-(
In-Reply-To: <Pine.LNX.4.05.9905241810150.650-100000@pc.wackyland.com>
Message-ID: <Pine.LNX.4.10.9905251249001.6781-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>





On Mon, 24 May 1999, Tom Rini wrote:

> 
> On Tue, 25 May 1999 laures@esiea.fr wrote:
> 
> > On 24 Mai, Tom Rini wrote:
> >
> > > you go:
> > > pdisk /dev/blank-inito-disk
> > > ... create partitions ...
> > This is not possible since pdisk reports a incredible number of 512
> > bytes block for a 256M disk (the test drive), with a total free space
> > of 126G!!!
> > Here pdisk fail at creating the partition map, and at modifying it
> > sjightly.
> > I wish I could show you the output of pdisk, is it possible to redirect
> > output on a file, still setting the keyborad as input ?
> 
> pdisk /dev/blah >log 2>&1
> then type blindly.
>  

Isn't script a better choise ? 

  Kostas Gewrgiou


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
