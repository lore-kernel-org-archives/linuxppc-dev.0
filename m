Date: Tue, 30 Nov 1999 12:44:41 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Paul Mackerras <paulus@linuxcare.com>
cc: Martin Costabel <costabel@wanadoo.fr>, Shaw Terwilliger <sterwill@io.nu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.30-pre3
In-Reply-To: <99120107124704.02316@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.4.10.9911301241440.3982-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 1 Dec 1999, Paul Mackerras wrote:

> I think that Shaw possibly got a corrupted include/asm-ppc/keyboard.h,
> maybe I was updating it as he was fetching it or something.  I have
> changed the ifdef in chipsfb.c as Shaw suggested.

	actually, Shaw's chips fb patch is wrong, in the sense that it
isn't a complete fix.  as Martin noted, i "fixed" chipsfb a while ago back
in 2.3.25 or so, there are some structs which are undefined which are used
in xpmac_compat code, please refer to the 2.3.25-ppc.patch in my directory
on devel, devel.linuxppc.org/users/ajoshi for a proper chipsfb patch.



ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
