Message-ID: <3E91C1E2.4060502@mvista.com>
Date: Mon, 07 Apr 2003 11:22:26 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patch for PCORE on linuxppc_2_4_devel
References: <3E8E2D71.8050707@mvista.com> <20030407174355.GD16622@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030407174355.GD16622@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

>On Fri, Apr 04, 2003 at 06:12:17PM -0700, Mark A. Greer wrote:
>
>
>
>>This patch does the following:
>>a) Modifies the CONFIG_MORE_COMPILE_OPTIONS setup at the bottom of
>>arch/ppc/config.in.  The way that it was didn't work well and seemed
>>difficult to read.  I believe that the new way is "more correct" and
>>easier to understand
>>
>>
>
>Didn't work well when?  Then intent is that if you don't select this
>option, you still get -g added when CONFIG_KGDB=y so that you can
>effectivly use gdb.
>
Try playing with it a little...

I understand the intent, it just didn't work well.  The option is still
there with a reasonable default.  If they want it, they can use it; if
they don't, they don't.  If they don't know that they probably want -g
if they have KGDB, they'll find out soon enough.  Simple.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
