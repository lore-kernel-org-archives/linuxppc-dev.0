Message-ID: <XFMail.20030829091718.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <20030828120243.A50750@forte.austin.ibm.com>
Date: Fri, 29 Aug 2003 09:17:18 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: linas@austin.ibm.com
Subject: Re: Random crashes
Cc: linuxppc-dev@lists.linuxppc.org
Cc: linuxppc-dev@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 28-Aug-2003 linas@austin.ibm.com wrote:
> On Wed, Aug 27, 2003 at 10:06:27PM +0200, Giuliano Pochini wrote:
>>
>> > > Random... lockups, oopses, sig11... but nothing useful because is happens
>> > > in random places. Ok, so the answer is no. Maybe the hw is faulty. It's
>> > > the only kernel I used on this mac.
>
> Can you monitor cpu temp somehow? I had this once when a cpu fan would
> barely spin.

I cannot monitor the tempeature directly because AFAIK that feature is
not available on 7455. The g4fan driver by Samuel Rydh says the temp.
is always around 59C. But I don't think this is the cause because I also
tried to keep the fans at full speed (~50C) with same results.

> Slightly off-topic: I've always wanted to have a memory-cache checker
> kerneld that ran continuously in the background.
>
> More off-topic. I've always wanted to have an on-line, background fsck
> checker running continuously.   I've had problems where a journalling
> FS would think the FS was fine, log journal clean, but in fact, the fs
> had slowly accumulated errors over many months due to ?? faulty
> electronics ??.

Small bugs, more likely. All journalling fs are still beta.


Bye.
    Giuliano.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
