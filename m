In-Reply-To: <199910071913.VAA00361@piglet.cpu.lu>
Date: Fri, 8 Oct 1999 12:18:23 +0200
To: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: busmaster/latency for video
Message-Id: <19991008121823.016009@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 7, 1999, Michel Lanners <mlan@cpu.lu> wrote:

>Ah, but in that case Apple's OF should enable bus mastering. If I read
>well between the lines of Apple's docs, OF should set a few default
>parameters on all PCI devices, among which bus mastering. I'm not sure
>about latency, though...

OF tends to ignore devices that don't have an OF expansion ROM. (For
example, it won't enable memory or IO accesses in the command register).
I beleive it won't enable bus mastering neither but I may be wrong.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
