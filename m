Subject: Re: asm inline
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20021129160826.GA27950@ibrium.se>
References: <20021129160826.GA27950@ibrium.se>
Content-Type: text/plain
Date: 29 Nov 2002 17:30:52 +0100
Message-Id: <1038587452.4040.22.camel@zion>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2002-11-29 at 17:08, Samuel Rydh wrote:
>
> I just noticed that gcc 3.1 doesn't like the following:

According to Franz Sirl, gcc 3.2.1 is one of the very first gcc's
to not need any special patch for known bugs for PPC32 :) I'd
suggest you try this one.

I couldn't reproduce that bug with debian sid's gcc 2.95.4, 3.0.4 and
3.2.1

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
