Date: Wed, 6 Feb 2002 11:11:41 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Matthias Grimm <joker@cymes.de>,
	LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Why is the Powerbook Fn-Key handled differently?
In-Reply-To: <1012903423.1594.533.camel@pismo>
Message-ID: <Pine.LNX.4.33.0202061108590.9154-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 5 Feb 2002, Michel Dänzer wrote:
> If the fn key generates a keycode, existing shortcuts involving it won't
> work anymore, will they? I'm specifically thinking of stuff like
> ctrl-alt-{+,-} to switch resolutions in X.

Not if that keycode is interpreted as modifier keycode in handle_scancode
(assuming XFree doesn't set the console to VC_RAW; if it does it needs
to be taught to handle Fn as modifier anyway)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
