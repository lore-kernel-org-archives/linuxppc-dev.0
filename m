From: samuel@ibrium.se
Date: Sun, 15 Sep 2002 14:50:01 +0200
To: Segher Boessenkool <segher@koffie.nl>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Performance Monitor Counters device
Message-ID: <20020915145001.B1937@ibrium.se>
References: <3D810AF2.2034238C@koffie.nl> <20020912102550.11578@192.168.4.1> <3D831D5A.BF11BC0D@koffie.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D831D5A.BF11BC0D@koffie.nl>; from segher@koffie.nl on Sat, Sep 14, 2002 at 01:28:26PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Sep 14, 2002 at 01:28:26PM +0200, Segher Boessenkool wrote:
> Okay, here's the data I found on that errata:
>
> It does not exist on 7450 etc.
> It exists on 7410 before version 1.3 .
> I have no data on 7400.
> It does not exist on 750 etc.

Actually, I have experienced this bug on one of my 750-based machines
(possibly, only one of the revs were affected). If I were you, I would be
extremely careful using the TAU/performance interrupt.

/Samuel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
