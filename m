Message-Id: <200110111308.f9BD80f08581@ashley.ivey.uwo.ca>
Date: Thu, 11 Oct 2001 09:04:29 -0400
From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
Subject: Re: bug in XFree86 4.1.0 with Rage 128 driver?
Cc: =?iso-8859-1?Q?Michel_D=E4nzer?= <michdaen@iiic.ethz.ch>,
	linuxppc-dev@lists.linuxppc.org, Herbert Duerr <duerr@sun.com>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20011011134940.A3720@suse.de>
Mime-Version: 1.0 (Apple Message framework v388)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

>> Why does it work with the fbdev driver then?

Just a guess.

Since we are using an uninitialized variable whatever was in memory
previously determined the value of xFormat.  So the result was random
behavior when checking for formats.

So anything that changed the stack usage or memory layout would / should
have an impact.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
