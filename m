Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "James Don" <JDon@spacebridge.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Cross Compile Build Question
Date: Wed, 29 Jan 2003 20:54:56 -0800
Message-ID: <NCBBIINEHIPFGJPLBEIFKEIOEBAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <DB0585C9F6F9D411BE8F00D0B7896A4CC06124@SNCMAIL>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Let me dig up my notes. I spent an hour with someone before we got this to
work. You needed to comment out some stuff.

> I am trying to build GCC with the below 3 scripts build-gccBootStrap.sh,
> build-glibc.sh, and build-gccWithGlibc.sh ... I keep having
> problems once I
> get to the part where gcc is build gthr-threads.h ...
>
> I can build glibc and bootstrapped compiler with newlib just fine ...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
