Date: Sun, 22 Jul 2001 16:01:09 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Rob the Lathaminator <rob@terizla.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: suspend to disk
Message-ID: <20010722160108.B13085@altus.drgw.net>
References: <20010720123022.G18600@turok.clustermonkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010720123022.G18600@turok.clustermonkey.org>; from rob@terizla.org on Fri, Jul 20, 2001 at 12:30:22PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 20, 2001 at 12:30:22PM -0500, Rob the Lathaminator wrote:
>
> I don't know of any other software suspend to disk projects besides
> http://falcon.sch.bme.hu/~seasons/linux/swsusp.html, and it is i386
> only.
>
> so i was going to look at porting it, unless any of the heavy hitter ppc
> kernel hackers have a better approach for software suspend to disk on
> ppc...

I'd suggest using the powerbook sleep code.. although I don't know how
this would interact with writing things out to the disk..

Benh, any thoughts?


--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Shulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
