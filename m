Date: Mon, 24 May 1999 18:10:43 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: laures@esiea.fr
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Initio miles tests :-(
In-Reply-To: <199905242203.SAA10401@mail.ntplx.net>
Message-ID: <Pine.LNX.4.05.9905241810150.650-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 25 May 1999 laures@esiea.fr wrote:

> On 24 Mai, Tom Rini wrote:
>
> > you go:
> > pdisk /dev/blank-inito-disk
> > ... create partitions ...
> This is not possible since pdisk reports a incredible number of 512
> bytes block for a 256M disk (the test drive), with a total free space
> of 126G!!!
> Here pdisk fail at creating the partition map, and at modifying it
> sjightly.
> I wish I could show you the output of pdisk, is it possible to redirect
> output on a file, still setting the keyborad as input ?

pdisk /dev/blah >log 2>&1
then type blindly.
 
---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
