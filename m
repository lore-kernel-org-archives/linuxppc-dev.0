Date: Thu, 16 Mar 2000 17:45:44 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: "Jo-Ellen F. Mathews" <joellen@absoval.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux Planet Module Support
In-Reply-To: <Pine.LNX.3.96.1000316161543.23230C-100000@tristar.cc.absoval.com>
Message-ID: <Pine.LNX.4.21.0003161741590.901-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

> When I comment out these two lines, the compiler errors continue to get
> worse.

Anyway, go ahead and remove all the symbols that cannot be exported.
The kernel will eventually compile and work.

IMHO, ppc_ksyms.c should become a generated file some day. What's the
point in exporting functions that the modules don't use anyway?

Pavel Roskin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
