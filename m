From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Sep 2000 18:31:36 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [linux-fbdev] Re: Xfree86-4.0.1, Lombard, Mach64 driver
CC: Benjamin Herrenschmidt <bh40@calva.net>,
        Jon Erick Ween <jween@som.llu.edu>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu, toe@unlserve.unl.edu
Message-ID: <8876DA34084@vcnet.vc.cvut.cz>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 29 Sep 00 at 13:05, Geert Uytterhoeven wrote:
> The main thing we need to be careful about is that the xor mask is different
> for truecolor and directcolor visuals: truecolor needs an `all ones' mask,
> while directcolor needs `15' for each color component (drivers that incorrectly
> report a directcolor instead of truecolor visual will easily be identified).

What about killing directcolor completely, and using directcolor capable
hardware as truecolor one with per-fb global gamma correction table?
(as windows do...)

List of modified files is shorter then ;-)
                                                        Petr


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
