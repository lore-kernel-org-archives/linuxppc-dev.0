Date: Wed, 17 Mar 2004 10:00:09 -0800
From: Ira Weiny <iweiny@acm.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Random crashes on snooze
Message-Id: <20040317100009.0c98e508.iweiny@acm.org>
In-Reply-To: <1079508204.935.69.camel@gaston>
References: <20040316230925.15bfe069.iweiny@acm.org>
	<1079508204.935.69.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Mar 2004 18:23:24 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>
> > But I don't know if there is something missing from the file because of course
> > nothing can be written to the disk at this time...  Does anyone have any other
> > clues?
> >
>
> Does it improve things if you disable the driver ?
>
>

I just disabled the driver last night after emailing the list.  I have not had
it crash yet.  So?  Maybe?  The randomness nature of this has made it
frustrating to determine if what I have done helps.  I have tried disabling
other things and thought "hey that worked!" only to have it crash on the next
sleep!!!  :-(

I got another response which said he had to disable the sound driver on his
Lombard before sleep.  I will continue to investigate.

Thanks,
Ira


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
