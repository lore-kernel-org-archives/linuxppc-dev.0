From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Fink <billfink@mindspring.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] Minor changes to control/imstt/platinum/valkyrie/atyfb
Date: Mon, 3 Dec 2001 00:59:53 +0100
Message-Id: <20011202235953.3323@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.33.0112030257230.5627-100000@gwiz.nasa.atd.net>
References: <Pine.LNX.4.33.0112030257230.5627-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Wasn't there a tool to fiddle and store the vmode/cmode stuff into NVRAM
>> tho which would probably work with all of the other cards?
>
>nvvideo, which could set either a video-mode or a color-mode, but I
>don't think the color-mode was the same thing as the cmode.  I had to
>use a color-mode of 3 IIRC (with a video-mode of 18) to get a decent
>display on a 7200 at work (which had a platinum FB IIRC).

Same problem, the information there is driver specific and the
tool currently use a fix offset instead of properly handling the
nvram device tree extension format (afaik). The cmode is also a
driver specific thing and is equivalent to the MacOS driver
"DepthMode" setting, which will map differently to bit depths
depending on the MacOS driver you are dealing with.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
