Date: Tue, 10 Oct 2000 02:06:22 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: jcarr@linuxppc.org
cc: Paul Mackerras <paulus@linuxcare.com.au>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: call_prom & call_method_1
In-Reply-To: <Pine.LNX.4.10.10009160815360.24020-100000@jcarr.linuxppc.org>
Message-ID: <Pine.HPX.4.10.10010100126530.16113-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 9 Oct 2000 jcarr@linuxppc.org wrote:

> 1) Does anyone know what other strings can be sent to call_prom besides
> "getprop", "findpackage", "interpret"?

If you go to /openprom/client-interface or something like this (I'm away
from my OF machines at the moment), you can list these commands with
words. These are the methods of this package.

> 2) Are those strings words within OF that can been looked at with see?

AFAIR yes, but they won't tell you much. Very often they are short
wrappers around a known Forth word only playing with the stack to modify
the order of parameters and change the format of strings.

> 3) Can a phandle
>
> Nonetheless, without having a better correlation between the strings
> ("getprop", "setprop", "findpackage", "interpret") and what those strings
> do( and what other valid strings can be used ) it will be hard to receive
> feedback from the mouse.

Well, let me know if you want more info, but actually it's quite simple.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
