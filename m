To: linuxppc-dev@lists.linuxppc.org
Cc: guile@mac.com
Subject: Re: VGA out on ibook2
From: paulotex@yahoo.com (Paulo Abreu)
Date: Fri, 12 Oct 2001 08:36:02 +0100
In-Reply-To: <200110120459.XAA10187@lists.linuxppc.org>
References: <200110120459.XAA10187@lists.linuxppc.org>
Message-ID: <20011012083602.385%96000@smtp.netc.pt>
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Linux PPC Developer Digest wrote:
>Hi
>	I'm trying to use the external VGA connector on an ibook2 (the white
>one) with the benh utility m3mirror and, after turning crt on, the
>screen on the monitor looks "wavy" and unusable.
>	Anybody could guide me to solve this problem?

Same problem here. If I include the crt:1 option in the kernel booting
options, the waves dissapear and the console looks good, but the X
colors are all wrong. Looks like the crt is in 8bpp while X and the lcd
are in 16bpp. Tried this with 2.4.10-ben0.

Paulo


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
