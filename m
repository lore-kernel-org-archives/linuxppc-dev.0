Return-Path: <anton@ozlabs.org>
Date: Sun, 14 Oct 2007 16:03:05 -0500
From: Anton Blanchard <anton@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Quieten cache information at boot
Message-ID: <20071014210305.GE26693@kryten>
References: <20071014193317.GC26693@kryten> <20071014201431.GA23002@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071014201431.GA23002@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
Hi,

> Let's just remove it completely. I have yet to see a bug because of it,
> and we have 0x40 byte cache lines.

Yeah I completely support killing it too :)

> If anything, compare firmware setting to cputable one and print a warning.
> 
> Should maybe give them loglevels too, since you're touching them? I
> suggest KERN_DEBUG -- if needed it's there in dmesg, and if you need it
> on the console you can just add "debug" to the kernel command line.

I started playing with loglevels but theres some ordering issues since
the options to change loglevel (eg the "debug" boot option) doesnt get
parsed until later in a __setup function.

Anton
