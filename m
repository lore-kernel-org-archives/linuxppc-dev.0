Subject: Re: How to remove JFFS2 'Making dirty' display on RPXlite DW?
From: David Woodhouse <dwmw2@infradead.org>
To: Mark Chambers <markc@mail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <005301c47afc$d2599510$0301a8c0@chuck2>
References: <20040805042134.41548.qmail@web15610.mail.cnb.yahoo.com>
	 <004101c47af6$3f8d8800$0301a8c0@chuck2>
	 <1091717309.4383.4625.camel@hades.cambridge.redhat.com>
	 <005301c47afc$d2599510$0301a8c0@chuck2>
Content-Type: text/plain
Message-Id: <1091718257.4383.4627.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 05 Aug 2004 16:04:17 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-08-05 at 10:59 -0400, Mark Chambers wrote:
> Well, I've done it.  Dumb luck?  eraseall, then the command as shown, but I
> don't remember the rest of the options.

Yeah -- that should work as well as just making an image with the same
options, then writing it. But it would be nicer if it'd do the eraseall,
and interrogate the device to find its characteristics.

Please don't top-post.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
