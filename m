In-Reply-To: <19990330035423.A6273@persephone.ppc.kernel.org>
Date: Tue, 30 Mar 1999 12:58:54 +0200
To: linuxppc-dev@lists.linuxppc.org
CC: Cort Dougan <cort@ppc.kernel.org>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Yesterday vger and ioremap
Message-Id: <19990330125854.000150@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

vger tree from yesterday gives me tons of warnings of the style:
"__ioremap(). Overlap detected and handled for PA xxxxxxx VA xxxxxxxx"
when booting.

Apparently, the kernel works fine, PA seems to always be equal to VA, and
apparently, this concerns all addresses on the Apple asic (mac-io on the
G3), at f30xxxxx. 
Since this is mapped with a BAT, I'm wondering if this could be a
conflict between new ioremap changes and BAT mapping ?

(I didn't look at actual source code changes, the problem seems to be
harmless, just those messages in the console).

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
