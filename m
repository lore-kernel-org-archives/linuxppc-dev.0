Date: Thu, 18 Mar 2004 14:41:09 -0800
From: Ira Weiny <iweiny@acm.org>
To: linuxppc <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Random crashes on snooze
Message-Id: <20040318144109.484b51f8.iweiny@acm.org>
In-Reply-To: <20040317100009.0c98e508.iweiny@acm.org>
References: <20040316230925.15bfe069.iweiny@acm.org>
	<1079508204.935.69.camel@gaston>
	<20040317100009.0c98e508.iweiny@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Mar 2004 10:00:09 -0800
Ira Weiny <iweiny@acm.org> wrote:

>
> I just disabled the driver last night after emailing the list.  I have not had
> it crash yet.  So?  Maybe?  The randomness nature of this has made it
>

Well so far so good.  I will start digging in the awacs code to see if I can
figure out what leads up to the crash.  I did notice that it seemed worse after
the machine had been sitting idle for some time.  Maybe the awacs driver was
already powered down and there is something wrong with it's state when the
"snooze" comes in?

I will see if I can get more information.

Ira


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
