From: linas@austin.ibm.com
Date: Thu, 28 Aug 2003 12:02:44 -0500
To: Giuliano Pochini <pochini@shiny.it>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Random crashes
Message-ID: <20030828120243.A50750@forte.austin.ibm.com>
References: <20030824092456.3c36fa5b.pochini@shiny.it> <1061714789.753.12.camel@gaston> <20030824174408.520f2cb3.pochini@shiny.it> <1061740217.31688.33.camel@gaston> <20030827220627.1e437823.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030827220627.1e437823.pochini@shiny.it>; from pochini@shiny.it on Wed, Aug 27, 2003 at 10:06:27PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Aug 27, 2003 at 10:06:27PM +0200, Giuliano Pochini wrote:
>
> > > Random... lockups, oopses, sig11... but nothing useful because is happens
> > > in random places. Ok, so the answer is no. Maybe the hw is faulty. It's
> > > the only kernel I used on this mac.

Can you monitor cpu temp somehow? I had this once when a cpu fan would
barely spin.

Slightly off-topic: I've always wanted to have a memory-cache checker
kerneld that ran continuously in the background.

More off-topic. I've always wanted to have an on-line, background fsck
checker running continuously.   I've had problems where a journalling
FS would think the FS was fine, log journal clean, but in fact, the fs
had slowly accumulated errors over many months due to ?? faulty
electronics ??.   Biting the bullet and spending half a day on fsck
would reveal the problem; but that's an unhappy way to do things.

I guess i've got this jones for systems that run perfectly reliably
perfectly securely all the time ...

--linas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
