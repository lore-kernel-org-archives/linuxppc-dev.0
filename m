Subject: Re: Weird interrupt problem
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200208072028.01216.kevin.hendricks@sympatico.ca>
References: <1028761518.1262.1236.camel@tibook>
	<200208072028.01216.kevin.hendricks@sympatico.ca>
Content-Type: text/plain; charset=ISO-8859-1
Date: 08 Aug 2002 13:04:29 +0200
Message-Id: <1028804670.1109.1318.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2002-08-08 at 02:28, Kevin B. Hendricks wrote:
>
> Twice now I have seen something that may be related.  The whole system
> becomes very sluggish with either one or both cpus consuming 99% of
> capacity while receiving funny interrupt messages.
>
> I literally had to shutdown the system which took forever (I had to keep
> hitting <return> to allow the second cpu to have a chance at things).
>
> This is with an almost stock ben 2.4.19-pre10 kernel compiled for SMP on a
> Dual G4 1-gig machine.  I have never seen anything in the message logs
> that provides a good hint at why this is happening.
>
> Again it has only happended twice now but it is very annoying (the system
> becomes so sluggish you almost think it has hung completely).
>
> I have no idea if this is related but it may be.

I'm not sure, as this really seems to be related to USB, the CPU isn't
hogged and while the system is very jerky, it still runs at about half
the normal speed. No problem shutting down.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
