Date: Tue, 8 Aug 2000 19:48:54 +0200
From: Olaf Hering <olh@suse.de>
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Backlight control on Lombard PB
Message-ID: <20000808194854.A31709@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <200008080459.XAA04970@lists.linuxppc.org> <Pine.SOL.3.95.1000808191003.1384C-100000@juliet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SOL.3.95.1000808191003.1384C-100000@juliet>; from supas100@astrophysik.uni-kiel.de on Tue, Aug 08, 2000 at 07:22:44PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 08, Derek Homeier wrote:


> Besides, the keycodes 10 and 50 (less/greater and asciicircum/degree) on
> the german keyboard seem to have been swapped in pre13-pre15.

The current tree should have that problem fixed, proably the backlight
too. Can you rsync the current tree and try it?
rsync it in a vanilla 2.2.16 or use the binary at
ftp://ftp.suse.com/pub/suse/ppc/update/BETA/devel somewhere and rsync in
that tree. Just to reduce traffic.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
